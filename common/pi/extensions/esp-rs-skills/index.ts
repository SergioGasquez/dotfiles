import { homedir } from "node:os";
import { dirname, isAbsolute, join, relative } from "node:path";
import { fileURLToPath } from "node:url";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Pi's `.agents/skills` lookup stops at the git root, so skills for every
// esp-rs checkout (forks and worktrees included) are added here by location.
const ESP_RS_ROOT = join(homedir(), "Documents", "Espressif", "esp-rs");
const SKILLS_DIR = join(dirname(fileURLToPath(import.meta.url)), "skills");

export default function (pi: ExtensionAPI): void {
  pi.on("resources_discover", (event) => {
    const path = relative(ESP_RS_ROOT, event.cwd);
    const inEspRs = path !== "" && !path.startsWith("..") && !isAbsolute(path);
    return inEspRs ? { skillPaths: [SKILLS_DIR] } : {};
  });
}
