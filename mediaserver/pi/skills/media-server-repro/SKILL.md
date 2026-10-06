---
name: media-server-repro
description: Audits a local media server stack and produces a reproducibility bundle with detected apps, services, ports, paths, configs, launchd/brew/docker details, and optional sensitive backups. Use when documenting or migrating Sonarr/Radarr/Prowlarr/Jellyfin/Transmission/Bazarr/Seerr-style setups.
---

# Media Server Repro

Use this skill to inventory a local media server and create a bundle that makes the setup easier to reproduce.

## What this skill produces

The helper script creates:

- `REPORT.md`: human-readable summary
- `manifest.json`: machine-readable inventory
- `sanitized/`: redacted config and service files safe to inspect
- `commands/`: captured system command output
- `sensitive/`: optional raw config/database backup for private migration use only

## Default target

If no target is provided, the helper script prefers:

1. `~/Server/media-server`
2. current working directory

## Workflow

1. Confirm the target root with the user if ambiguous.
2. Run a sanitized inventory first.
3. Read `REPORT.md` and `manifest.json`.
4. Summarize:
   - apps detected
   - how each app is started
   - ports and paths
   - scripts/automation present
   - gaps that still require manual UI setup
5. Only create a sensitive bundle when the user explicitly wants a migration/backup artifact.

## Commands

Sanitized bundle:

```bash
python3 ~/.agents/skills/media-server-repro/scripts/collect_media_server_snapshot.py \
  --target-root ~/Server/media-server
```

Explicit output directory:

```bash
python3 ~/.agents/skills/media-server-repro/scripts/collect_media_server_snapshot.py \
  --target-root ~/Server/media-server \
  --output ~/Server/media-server/inventory-reports/latest
```

Include raw sensitive material for private backup/migration:

```bash
python3 ~/.agents/skills/media-server-repro/scripts/collect_media_server_snapshot.py \
  --target-root ~/Server/media-server \
  --include-sensitive
```

## Important safety note

Sensitive bundles may contain API keys, passwords, tokens, app databases, and credential files. Never commit `sensitive/` to git or share it publicly.

## After running

- Read `REPORT.md`
- Read `manifest.json`
- If present, read copied docs under `sanitized/project/docs/`
- Use [the collection reference](references/what-it-collects.md) if the user asks what is included or missing
