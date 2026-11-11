// Remembers the Pi session open in each Herdr terminal, so the shell Herdr Core
// starts in its place after a reboot can reopen it (see common/shell/config.fish).
import { mkdirSync, rmSync, writeFileSync } from "node:fs";
import { homedir } from "node:os";
import { join } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  const terminal = process.env.HC_TERMINAL_ID;
  if (!terminal) return;

  const dir = join(homedir(), ".pi/agent/herdr-terminals");
  const file = join(dir, terminal);
  let signalled = false;
  const onSignal = () => {
    signalled = true;
  };

  pi.on("session_start", (_event, ctx) => {
    const session = ctx.sessionManager.getSessionFile();
    if (ctx.mode !== "tui" || !session) return;
    mkdirSync(dir, { recursive: true });
    writeFileSync(file, session);
    process.on("SIGHUP", onSignal);
    process.on("SIGTERM", onSignal);
  });

  pi.on("session_shutdown", async (event) => {
    // Pi's own signal handler runs first and can start this shutdown before
    // onSignal runs; wait for the signal dispatch to finish.
    await new Promise((resolve) => setImmediate(resolve));
    process.off("SIGHUP", onSignal);
    process.off("SIGTERM", onSignal);
    // A power off or killed terminal keeps the session for the restarted
    // shell; quitting Pi yourself forgets it.
    if (event.reason === "quit" && !signalled) rmSync(file, { force: true });
  });
}
