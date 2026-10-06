# What the media-server-repro skill collects

## Detects

- Arr apps: Sonarr, Radarr, Prowlarr, Bazarr, Lidarr, Readarr
- Media servers/request apps: Jellyfin, Plex, Emby, Seerr/Jellyseerr, Overseerr
- Download clients: Transmission, qBittorrent, SABnzbd, Deluge, NZBGet, Jackett
- Service definitions from launchd, Homebrew services, and Docker metadata when available

## Collects in sanitized mode

- Host/system summary
- Running process matches
- Listening port matches
- `brew services list` and relevant package versions
- `docker ps` / `docker compose ls` when available
- LaunchAgent / LaunchDaemon plist files matching the media stack
- Text-based config files with secret-like values redacted
- Media-server project docs, helper scripts, boot-daemon files, and compose files
- A machine-readable manifest and human-readable report

## Collects only with `--include-sensitive`

- Raw config files
- App databases (`.db`, `.sqlite`, `.sqlite3`)
- Credential files from the media-server project
- Additional raw files useful for private migration

## Deliberately excluded from sanitized output

- Logs
- Large caches
- Prowlarr indexer definition corpus
- Git metadata and build artifacts
- Media payloads themselves

## Limitations

- UI-only settings stored in app databases are summarized indirectly unless `--include-sensitive` is used
- Some YAML-heavy apps are copied/redacted but not deeply parsed
- Containerized services are detected from local compose/runtime metadata only if Docker is installed and accessible
