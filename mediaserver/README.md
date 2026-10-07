# Media server and 3D printing services (macOS)

This describes the **current installation on this Mac**, not a one-command
installer. Application data, service definitions, and credentials live outside
this dotfiles repository. Paths below use `~` instead of a machine-specific
username; do not commit databases, API keys, printer access codes, or local
network details.

## Media stack

| App | Role | Installation and service | Local port |
| --- | --- | --- | --- |
| Jellyfin | Plays movies and shows | Homebrew cask; `local.jellyfin` system LaunchDaemon | 8096 |
| Sonarr | TV library and downloads | Homebrew cask; `local.sonarr` system LaunchDaemon | 8989 |
| Radarr | Movie library and downloads | Homebrew cask; `local.radarr` system LaunchDaemon | 7878 |
| Prowlarr | Indexers for Sonarr and Radarr | Homebrew cask; `local.prowlarr` system LaunchDaemon | 9696 |
| Bazarr | Subtitles for Sonarr and Radarr | Homebrew formula; `local.bazarr` system LaunchDaemon | 6767 |
| Transmission | Torrent downloads | Homebrew `transmission-cli` formula; `homebrew.mxcl.transmission-cli` system LaunchDaemon | 9091 (RPC/web) |
| Seerr | Requests for Jellyfin, Sonarr, and Radarr | Locally built Node/pnpm app; `local.seerr` **system** LaunchDaemon | 5055 |

The Homebrew-managed applications are installed in the usual Homebrew and
`/Applications` locations. Their configuration and databases are **not** kept
in this repo: Jellyfin, Radarr, Prowlarr, and Seerr use directories under
`~/Library/Application Support/`; Sonarr uses `~/.config/Sonarr`; Bazarr and
Transmission use `/opt/homebrew/var/`. Media lives under `~/Media/` (movies,
TV, and download folders). The services currently run via launchd, not Docker
or `brew services`. Legacy Jackett is disabled; it is not the active indexer
manager.

The local deployment project at `~/Server/media-server/` holds setup notes,
service plist templates (`boot-daemons/`), scripts, backups, and the Seerr app.
Installed system jobs are in `/Library/LaunchDaemons/`; copying a template into
that directory alone does not activate a service. The local scripts include
Jellyfin library refresh and watched-item cleanup, Transmission completed-item
cleanup, and Spanish-original tagging for Bazarr. Some automation runs via
user LaunchAgents; see `~/Server/media-server/scripts/` and the active launchd
jobs rather than assuming every template is installed. The setup notes in
`~/Server/media-server/docs/` may contain private host details and should not
be copied into this repository.

Seerr is a versioned local source install: `~/Server/media-server/seerr` is a
symlink to `~/Server/media-server/releases/seerr/v3.4.1`. Its config/database
is separate at `~/Library/Application Support/seerr`. The existing system
LaunchDaemon is **still active**. A matching user LaunchAgent is only staged at
`~/Server/media-server/launch-agents/local.seerr.plist`; it is **not** installed
in `~/Library/LaunchAgents/` or loaded. Do not load both jobs on port 5055.
The planned cutover requires disabling the root-owned system job first, then
starting and checking the user agent. A previous `pkexec` attempt failed on
this Mac, so the cutover remains pending.

## 3D printing and filament tracking

| App | Role | Installation and service | Local port |
| --- | --- | --- | --- |
| Spoolman | Filament inventory and usage database | Local Python app in a virtual environment; `local.spoolman` user LaunchAgent | 7912 |
| HaspelSync | Syncs Bambu Lab AMS spool state and print consumption with Spoolman | Local Node app; `local.haspelsync` user LaunchAgent | 4000 |

Spoolman runs from `~/Server/spoolman/app` using
`~/Server/spoolman/venv/bin/uvicorn`; its persistent data and backups are in
`~/Server/spoolman/data`, with logs in `~/Library/Logs/Spoolman`.
HaspelSync runs `entrypoint.js` from `~/Server/haspelsync/app` with dependencies
in `node_modules`. Its service sets `DATA_DIR=~/Server/haspelsync/data` and
writes logs under `~/Library/Logs/HaspelSync`. Also preserve runtime files in
`~/Server/haspelsync/app/printers/` when replacing the application: they may
contain printer configuration or state. HaspelSync talks to Spoolman and the
printer over the local network; do not publish printer identifiers or access
codes. Neither service currently runs in a container.

The stable app paths are symlinks into `releases/`:

| Stable path | Current release |
| --- | --- |
| `~/Server/spoolman/app` | `~/Server/spoolman/releases/v0.27.0` |
| `~/Server/haspelsync/app` | `~/Server/haspelsync/releases/1.3.3` |
| `~/Server/media-server/seerr` | `~/Server/media-server/releases/seerr/v3.4.1` |

These release directories contain the **existing installs**, not freshly
verified upstream archives. Spoolman and HaspelSync were restarted successfully
after the relocation. Seerr stayed running; its cold restart from the new path
has not been verified.

## Updates, backups, and checks

The macOS Zsh configuration in [`shell/zshrc`](shell/zshrc) is intended for
`~/.zshrc`; its mapping is commented out in [`.mappings`](../.mappings). Its `upup` updates Homebrew and explicitly checks the installed
Jellyfin, Sonarr, Radarr, and Prowlarr casks with `--greedy`, in addition to its
Cargo, Rust, Espressif, and Pi steps. The Fish `upup` in
[`mac-os/shell/config.fish`](../mac-os/shell/config.fish) runs the ordinary
Homebrew upgrade, not the extra cask checks. **Neither command updates the
source-installed Spoolman, HaspelSync, or Seerr.** Zsh prints a warning about
those three. A reliable updater would fetch/version a new release, back up the
persistent data (including HaspelSync runtime files), build outside the active
path, switch the symlink, restart the service, verify its health, and retain
its previous release for rollback. Database migrations may also need their own
rollback plan. Disk space is limited on this host; check it before staging
another Seerr build. Do not run the full `upup` merely to test these services.

Read-only local checks (ports are examples of the current setup):

```bash
launchctl list | grep -E 'local\.(spoolman|haspelsync)'
launchctl print system/local.seerr | grep -E 'state =|pid ='
for port in 7912 4000 5055; do curl -fsS -o /dev/null -w "$port: %{http_code}\n" "http://127.0.0.1:$port/"; done
```

The [media-server-repro Pi skill](pi/skills/media-server-repro/SKILL.md) can
create a sanitized inventory bundle. Its `~/.agents/skills/media-server-repro`
mapping is commented out in [`.mappings`](../.mappings). Its optional sensitive backup mode
requires explicit permission and must never be committed or shared publicly.
