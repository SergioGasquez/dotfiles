import { execFile, execFileSync, spawn } from "node:child_process";
import { readFileSync, readdirSync, readlinkSync, realpathSync } from "node:fs";
import { homedir } from "node:os";
import { basename, delimiter, join } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Notifications are best-effort; never hold up Pi or fail a prompt.
function run(command: string, args: string[], env?: NodeJS.ProcessEnv, onFailure = () => {}): void {
  const child = spawn(command, args, { stdio: "ignore", windowsHide: true, env });
  let failed = false;
  const fail = () => {
    if (failed) return;
    failed = true;
    onFailure();
  };
  child.on("error", fail);
  child.on("exit", (code) => {
    if (code !== 0) fail();
  });
  child.unref();
}

// Walk up the process tree to the GUI app hosting this terminal. __CFBundleIdentifier
// is unreliable: apps started from a CLI inherit it from the app that ran the CLI.
function findHostAppBundleId(): string | undefined {
  try {
    const processes = new Map<number, { ppid: number; command: string }>();
    for (const line of execFileSync("ps", ["-axo", "pid=,ppid=,comm="], { encoding: "utf8" }).split("\n")) {
      const match = /^\s*(\d+)\s+(\d+)\s+(.*)$/.exec(line);
      if (match) processes.set(Number(match[1]), { ppid: Number(match[2]), command: match[3] });
    }
    for (let pid = process.pid; pid > 1; ) {
      const entry = processes.get(pid);
      if (!entry) break;
      // The outermost bundle maps helpers such as "Cursor Helper.app" to the IDE itself.
      const app = /^(.*?\.app)\//.exec(entry.command)?.[1];
      if (app) {
        const plist = `${app}/Contents/Info.plist`;
        return execFileSync("plutil", ["-extract", "CFBundleIdentifier", "raw", plist], { encoding: "utf8" }).trim();
      }
      pid = entry.ppid;
    }
  } catch {}
  return undefined;
}

// Desktop entry IDs, and the real paths of the executables that visible entries launch.
function readDesktopEntries(): { ids: Set<string>; byExecutable: Map<string, string> } {
  const ids = new Set<string>();
  const byExecutable = new Map<string, string>();
  const dataDirs = [
    process.env.XDG_DATA_HOME || join(homedir(), ".local/share"),
    ...(process.env.XDG_DATA_DIRS || "/usr/local/share:/usr/share").split(":"),
  ];
  const resolve = (command: string): string | undefined => {
    const candidates = command.includes("/")
      ? [command]
      : (process.env.PATH ?? "").split(delimiter).map((dir) => join(dir, command));
    for (const candidate of candidates) {
      try {
        return realpathSync(candidate);
      } catch {}
    }
    return undefined;
  };
  for (const dir of dataDirs) {
    let files: string[];
    try {
      files = readdirSync(join(dir, "applications"));
    } catch {
      continue;
    }
    for (const file of files) {
      const id = file.replace(/\.desktop$/, "");
      // Earlier data directories take precedence.
      if (id === file || ids.has(id)) continue;
      ids.add(id);
      try {
        const groups = readFileSync(join(dir, "applications", file), "utf8").split(/^\[/m);
        const group = groups.find((g) => g.startsWith("Desktop Entry]"));
        const field = (key: string) => new RegExp(`^${key}\\s*=\\s*(.*)$`, "m").exec(group ?? "")?.[1].trim();
        // Skip URL handlers and terminal programs such as shells or editors.
        if (["Hidden", "NoDisplay", "Terminal"].some((key) => field(key) === "true")) continue;
        const command = /^"([^"]+)"|^(\S+)/.exec(field("Exec") ?? "");
        const executable = command && resolve(command[1] ?? command[2]);
        if (executable && !byExecutable.has(executable)) byExecutable.set(executable, id);
      } catch {}
    }
  }
  return { ids, byExecutable };
}

// PIDs of Pi's parent processes, nearest first.
function ancestorPids(): number[] {
  const pids: number[] = [];
  try {
    for (let pid = process.ppid; pid > 1; ) {
      pids.push(pid);
      const stat = readFileSync(`/proc/${pid}/stat`, "utf8");
      pid = Number(stat.slice(stat.lastIndexOf(")") + 2).split(" ")[1]);
    }
  } catch {}
  return pids;
}

// Find the desktop entry of the GUI app hosting this terminal. GIO_LAUNCHED_DESKTOP_FILE
// is unreliable: some terminals strip it and apps started from a CLI inherit it.
function findHostDesktopEntry(): string | undefined {
  try {
    const { ids, byExecutable } = readDesktopEntries();
    // Prefer the nearest ancestor whose executable a desktop entry launches.
    for (const pid of ancestorPids()) {
      try {
        const id = byExecutable.get(readlinkSync(`/proc/${pid}/exe`).replace(/ \(deleted\)$/, ""));
        if (id) return id;
      } catch {}
    }
    // Otherwise use the systemd unit the desktop created when launching the app, such as
    // app-gnome-dev.zed.Zed\x2dPreview-1234.scope or app-com.mitchellh.ghostty.service.
    const cgroup = /^0::(.*)$/m.exec(readFileSync("/proc/self/cgroup", "utf8"))?.[1] ?? "";
    for (const unit of cgroup.split("/").reverse()) {
      const match = /^app-(?:.*-)?([^-@]+)(?:-[^-]+\.scope|(?:@[^.]*)?\.service)$/.exec(unit);
      const id = match?.[1].replace(/\\x([0-9a-f]{2})/gi, (_, hex) => String.fromCharCode(parseInt(hex, 16)));
      if (id && ids.has(id)) return id;
    }
  } catch {}
  return undefined;
}

const windowCalls = ["call", "org.gnome.Shell", "/org/gnome/Shell/Extensions/Windows", "org.gnome.Shell.Extensions.Windows"];

// Find the window hosting this terminal through the Window Calls GNOME extension.
// Resolves undefined when the extension is not running or no window matches.
function findHostWindow(project: string): Promise<number | undefined> {
  return new Promise((resolve) => {
    execFile("busctl", ["--user", "--json=short", ...windowCalls, "List"], (error, stdout) => {
      try {
        if (error) return resolve(undefined);
        const windows: { id: number; pid: number; title: string | null }[] = JSON.parse(JSON.parse(stdout).data[0]);
        const pids = new Set(ancestorPids());
        const hosts = windows.filter((window) => pids.has(window.pid));
        // Apps such as Zed or Ghostty own all their windows from one process; prefer the
        // window titled after the project, else the topmost (windows are listed bottom-up).
        resolve((hosts.find((window) => window.title?.includes(project)) ?? hosts.at(-1))?.id);
      } catch {
        resolve(undefined);
      }
    });
  });
}

export default function (pi: ExtensionAPI): void {
  // macOS bundle ID or Linux desktop entry ID. undefined until looked up; null when no
  // host app was found (e.g. tmux, SSH).
  let hostApp: string | null | undefined;

  // Unlike agent_end, this fires only after retries and queued follow-ups finish.
  pi.on("agent_settled", (_event, ctx) => {
    // Background/print invocations (including editor tasks) should not notify.
    if (ctx.mode !== "tui") return;

    const title = `Pi: ${basename(ctx.cwd)}`;
    const body = "Ready for input";

    if (process.platform === "darwin") {
      hostApp ??= findHostAppBundleId() ?? null;
      const activate = hostApp ? ["-activate", hostApp] : [];
      // osascript notifications cannot focus the host app on click; use them only
      // when terminal-notifier is missing or not allowed to notify.
      run("terminal-notifier", ["-title", title, "-message", body, ...activate], undefined, () =>
        run("osascript", [
          "-e", "on run argv",
          "-e", "display notification (item 2 of argv) with title (item 1 of argv)",
          "-e", "end run",
          title, body,
        ]),
      );
    } else if (process.platform === "win32") {
      const script =
        "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; " +
        "$n = New-Object System.Windows.Forms.NotifyIcon; $n.Icon = [System.Drawing.SystemIcons]::Information; " +
        "$n.Visible = $true; $n.ShowBalloonTip(10000, $env:PI_NOTIFY_TITLE, $env:PI_NOTIFY_BODY, 'Info'); " +
        "Start-Sleep -Seconds 10; $n.Dispose()";
      run("powershell.exe", ["-NoProfile", "-Command", script], {
        ...process.env,
        PI_NOTIFY_TITLE: title,
        PI_NOTIFY_BODY: body,
      });
    } else if (process.platform === "linux") {
      hostApp ??= findHostDesktopEntry() ?? null;
      const hint = hostApp ? [`--hint=string:desktop-entry:${hostApp}`] : [];
      void findHostWindow(basename(ctx.cwd)).then((windowId) => {
        if (windowId === undefined) {
          // GNOME activates the desktop entry's app when the notification is clicked, but
          // removes the notification once its sender exits, so wait until it is closed.
          run("notify-send", ["--app-name=Pi", ...(hostApp ? ["--wait", ...hint] : []), title, body]);
          return;
        }
        // A default action replaces GNOME's app activation, which cannot pick a window
        // and does not raise some apps. notify-send prints the action once clicked.
        const script = `id=$1; shift; [ "$(notify-send "$@")" = default ] && exec busctl --user ${windowCalls.join(" ")} Activate u "$id"`;
        run("sh", ["-c", script, "sh", String(windowId), "--app-name=Pi", ...hint, "--action=default=Focus", title, body]);
      });
    }
  });
}
