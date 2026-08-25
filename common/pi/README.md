# Pi

The shared Pi configuration is linked to `~/.pi/agent` through
[`.mappings`](../../.mappings). Its packages are declared in
[`settings.json`](settings.json).

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
server. With a local Cursor model, the tool path is:

```text
Cursor model → pi-cursor-sdk bridge → pi-mcp-adapter → Konnect → KiCad
```

The Pi-to-Cursor bridge is local-only, so use the default local Cursor runtime
for Konnect rather than Cursor Cloud.

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

Restart Pi from the project directory, or run `/reload`, then use `/mcp` to
confirm that `konnect` was discovered. Most live PCB operations require KiCad
to be running with the target board open.

`pi-mcp-adapter` keeps Konnect's large tool catalog behind its proxy by default.
Do not enable all Konnect tools as direct tools; let the agent discover the
needed toolsets on demand.
