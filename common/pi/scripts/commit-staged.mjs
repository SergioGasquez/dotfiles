// Commit and push the staged changes of the current Git repository with Pi.
//
// Runs Pi in a detached background process so the editor task exits right
// away, then reports the result with a desktop notification.
import { spawn, spawnSync } from "node:child_process";
import { createHash } from "node:crypto";
import { readFileSync, rmSync, statSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { basename, join } from "node:path";
import { fileURLToPath } from "node:url";

const PROMPT =
  "/skill:git Commit the currently staged changes and push them. Commit and push are authorized. " +
  "Commit only what is staged and do not stage, unstage, or modify any other files. " +
  "Push the current branch to its upstream, or to origin with upstream tracking if it has none. " +
  "End your reply with one line containing the short commit hash, the commit subject, and where it was pushed.";

const isWindows = process.platform === "win32";
const cwd = process.cwd();
const repo = basename(cwd);
const id = `${repo}-${createHash("sha1").update(cwd).digest("hex").slice(0, 8)}`;
const logPath = join(tmpdir(), `pi-commit-staged-${id}.log`);
const lockPath = join(tmpdir(), `pi-commit-staged-${id}.lock`);

function notify(title, body) {
  const options = { stdio: "ignore", windowsHide: true };
  if (process.platform === "darwin") {
    spawnSync(
      "osascript",
      ["-e", "on run argv", "-e", "display notification (item 2 of argv) with title (item 1 of argv)", "-e", "end run", title, body],
      options,
    );
  } else if (isWindows) {
    const script =
      "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; " +
      "$n = New-Object System.Windows.Forms.NotifyIcon; $n.Icon = [System.Drawing.SystemIcons]::Information; " +
      "$n.Visible = $true; $n.ShowBalloonTip(10000, $env:PI_NOTIFY_TITLE, $env:PI_NOTIFY_BODY, 'Info'); " +
      "Start-Sleep -Seconds 10; $n.Dispose()";
    spawnSync("powershell.exe", ["-NoProfile", "-Command", script], {
      ...options,
      env: { ...process.env, PI_NOTIFY_TITLE: title, PI_NOTIFY_BODY: body },
    });
  } else {
    spawnSync("notify-send", ["--app-name=Pi", title, body], options);
  }
}

function lastLine(text) {
  return text.trim().split(/\r?\n/).filter(Boolean).pop() ?? "";
}

function isRunning(pid) {
  try {
    process.kill(pid, 0);
    return true;
  } catch (error) {
    return error.code === "EPERM";
  }
}

// Take the per-repository lock, unless another run still holds it.
function acquireLock() {
  try {
    writeFileSync(lockPath, "", { flag: "wx" });
    return true;
  } catch (error) {
    if (error.code !== "EEXIST") throw error;
  }
  const pid = Number(readFileSync(lockPath, "utf8"));
  // An empty lock belongs to a launcher that is still starting its worker.
  const starting = !pid && Date.now() - statSync(lockPath).mtimeMs < 10_000;
  if (starting || (pid && isRunning(pid))) return false;
  writeFileSync(lockPath, "");
  return true;
}

function runWorker() {
  // pi is a .cmd shim on Windows, which needs a shell to run.
  const args = ["--print", "--no-approve", "--thinking", "low", isWindows ? `"${PROMPT}"` : PROMPT];
  // Pi waits for piped stdin to end before starting, so give it none.
  const pi = spawn("pi", args, {
    cwd,
    shell: isWindows,
    stdio: ["ignore", "pipe", "pipe"],
    windowsHide: true,
  });
  let output = "";
  pi.stdout.on("data", (chunk) => (output += chunk));
  pi.stderr.on("data", (chunk) => (output += chunk));
  pi.on("error", (error) => (output += `\n${error.message}`));
  pi.on("close", (code) => {
    writeFileSync(logPath, output);
    rmSync(lockPath, { force: true });
    if (code === 0) {
      notify(`Pi: ${repo} committed and pushed`, lastLine(output) || "Done.");
    } else {
      notify(`Pi: ${repo} commit failed`, `${lastLine(output)}\nLog: ${logPath}`);
    }
  });
}

function start() {
  const staged = spawnSync("git", ["diff", "--cached", "--quiet"], { cwd, windowsHide: true });
  if (staged.status === 0) {
    notify(`Pi: ${repo}`, "Nothing is staged.");
    return;
  }
  if (staged.status !== 1) {
    notify(`Pi: ${repo}`, "Not a Git repository.");
    return;
  }
  if (!acquireLock()) {
    notify(`Pi: ${repo}`, "A commit is already in progress.");
    return;
  }
  const worker = spawn(process.execPath, [fileURLToPath(import.meta.url), "--worker"], {
    cwd,
    detached: true,
    stdio: "ignore",
    windowsHide: true,
  });
  writeFileSync(lockPath, String(worker.pid));
  worker.unref();
  notify(`Pi: ${repo}`, "Committing and pushing staged changes in the background…");
}

if (process.argv.includes("--worker")) {
  runWorker();
} else {
  start();
}
