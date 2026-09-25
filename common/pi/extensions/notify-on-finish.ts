import { execFileSync, spawn } from "node:child_process";
import { basename } from "node:path";
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

export default function (pi: ExtensionAPI): void {
  // undefined until looked up; null when no host app was found (e.g. tmux, SSH).
  let hostAppBundleId: string | null | undefined;

  // Unlike agent_end, this fires only after retries and queued follow-ups finish.
  pi.on("agent_settled", (_event, ctx) => {
    // Background/print invocations (including editor tasks) should not notify.
    if (ctx.mode !== "tui") return;

    const title = `Pi: ${basename(ctx.cwd)}`;
    const body = "Ready for input";

    if (process.platform === "darwin") {
      hostAppBundleId ??= findHostAppBundleId() ?? null;
      const activate = hostAppBundleId ? ["-activate", hostAppBundleId] : [];
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
      run("notify-send", ["--app-name=Pi", title, body]);
    }
  });
}
