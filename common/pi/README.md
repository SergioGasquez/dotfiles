# Pi

The shared Pi configuration is linked to `~/.pi/agent` through
[`.mappings`](../../.mappings). Its packages are declared in
[`settings.json`](settings.json).

## Instructions and skills

[`AGENTS.md`](AGENTS.md) defines shared coding preferences and authority boundaries.
The [Espressif](../agents/espressif/AGENTS.md) and
[Crimpdeq](../agents/crimpdeq/AGENTS.md) workspace instructions add domain-specific
policy. Skills under [`skills/`](skills/) load for branch creation/naming, commit
messages/commits, or code review—not for unrelated implementation work.

Implementation proceeds through scoped edits and relevant safe validation without
an automatic first-pass review stop. Reviews and audits remain read-only; drafting
a commit message does not authorize a commit. Commits and publication require a
request or explicit workspace authorization: Espressif issue implementation and
Crimpdeq implementation include committing and pushing personal task branches,
unless local-only work is requested. PR creation, posted reviews, force-pushes,
merges, releases, host setup changes, and hardware operations are not implicitly
authorized by that workflow.

Keep validation commands and domain invariants in the relevant project. Read
references according to the affected behavior rather than requiring a stack of
documents for every edit. These policies are shared across models; model selection
and package-owned delegation controls are unchanged.

## Extensions

- [`pi-cursor-sdk`](https://github.com/fitchmultz/pi-cursor-sdk) runs Cursor
  models inside Pi and bridges active Pi tools to local Cursor agents.
- [`pi-mcp-adapter`](https://github.com/nicobailon/pi-mcp-adapter) connects Pi
  to MCP servers through a small, on-demand proxy tool.

Install or restore both packages after installing Pi:

```bash
pi install npm:pi-cursor-sdk
pi install npm:pi-mcp-adapter
pi list
```

Restart Pi after installing the packages. Configure a Cursor API key with
`/login`, then select a `cursor/*` model with `/model`.

## KiCad through Konnect

[`Konnect`](https://github.com/mixelpixx/Konnect) is a KiCad 10 plugin and MCP
server. It works with any tool-capable model in Pi:

```text
Pi model → pi-mcp-adapter → Konnect → KiCad
```

Cursor models additionally use the `pi-cursor-sdk` bridge. That bridge is
local-only, so use the default local Cursor runtime rather than Cursor Cloud.
No second MCP extension is needed.

### Install Konnect

1. Download the `konnect-pcm-...` archive for the current operating system from
   [Konnect releases](https://github.com/mixelpixx/Konnect/releases).
2. In KiCad 10, open **Plugin and Content Manager**, choose
   **Install from File**, and select the archive.
3. Restart KiCad and verify that **PCB Editor → Tools → External Plugins**
   contains **Konnect**.
4. Enable **Preferences → Plugins → Enable KiCad API** for live PCB editing.

On macOS, Konnect may also need the KiCad executable paths in
`~/Library/Application Support/konnect/config.toml`:

```toml
kicad_cli = "/Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli"
kicad_binary = "/Applications/KiCad/KiCad.app/Contents/MacOS/kicad"
ipc_address = "ipc:///tmp/kicad/api.sock"
```

### Register the MCP server

On Linux, [the managed MCP config](../../linux/mcp.json) is linked to
`~/.config/mcp/mcp.json`. It launches the binary from KiCad 10's default PCM
installation directory. The `env` executable forwards the binary path after
`pi-mcp-adapter` expands `${HOME}` in the argument; no shell wrapper is needed.
If KiCad uses a custom data directory, override the command in the untracked
`~/.pi/agent/mcp.json`.

On macOS or Windows, add a `konnect` entry to `~/.config/mcp/mcp.json` using
the actual installed binary path (merge with any existing servers):

```json
{
  "mcpServers": {
    "konnect": {
      "command": "/absolute/path/to/konnect"
    }
  }
}
```

Use `konnect.exe` on Windows, with forward slashes or escaped backslashes in
the JSON path. Do not run `konnect init` just to register MCP: it installs
Claude/Codex guidance, not Pi's server configuration.

Restart Pi from the project directory, or run `/reload`, then use `/mcp` to
confirm that `konnect` was discovered. Ask the agent to connect and call
`server_stats` to verify MCP communication, then `list_toolboxes` to discover
available toolsets. Load only what is needed with `load_toolset`, for example
`{"name":"pcb_components"}`, then search the refreshed catalog.
Most live PCB operations require KiCad to be running with the target board
open. Test with a read-only inspection before requesting any design changes.

`pi-mcp-adapter` keeps Konnect's large tool catalog behind its proxy by default.
Do not enable all Konnect tools as direct tools; let the agent discover the
needed toolsets on demand.
