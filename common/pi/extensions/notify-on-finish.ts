import { spawn } from "node:child_process";
import { basename } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI): void {
  // Unlike agent_end, this fires only after retries and queued follow-ups finish.
  pi.on("agent_settled", (_event, ctx) => {
    // Background/print invocations (including editor tasks) should not notify.
    if (ctx.mode !== "tui") return;

    const title = `Pi: ${basename(ctx.cwd)}`;
    const body = "Ready for input";
    const options = { stdio: "ignore" as const, windowsHide: true };
    let child;

    if (process.platform === "darwin") {
      child = spawn(
        "osascript",
        ["-e", "on run argv", "-e", "display notification (item 2 of argv) with title (item 1 of argv)", "-e", "end run", title, body],
        options,
      );
    } else if (process.platform === "win32") {
      const script =
        "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; " +
        "$n = New-Object System.Windows.Forms.NotifyIcon; $n.Icon = [System.Drawing.SystemIcons]::Information; " +
        "$n.Visible = $true; $n.ShowBalloonTip(10000, $env:PI_NOTIFY_TITLE, $env:PI_NOTIFY_BODY, 'Info'); " +
        "Start-Sleep -Seconds 10; $n.Dispose()";
      child = spawn("powershell.exe", ["-NoProfile", "-Command", script], {
        ...options,
        env: { ...process.env, PI_NOTIFY_TITLE: title, PI_NOTIFY_BODY: body },
      });
    } else if (process.platform === "linux") {
      child = spawn("notify-send", ["--app-name=Pi", title, body], options);
    }

    // Notifications are best-effort; never hold up Pi or fail a prompt.
    child?.on("error", () => {});
    child?.unref();
  });
}
