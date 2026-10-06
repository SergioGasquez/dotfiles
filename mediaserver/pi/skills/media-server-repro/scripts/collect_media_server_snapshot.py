#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import json
import os
import plistlib
import re
import shutil
import socket
import subprocess
import sys
from datetime import datetime
from pathlib import Path
from typing import Any
import xml.etree.ElementTree as ET


APP_DEFS = [
    {
        "name": "sonarr",
        "display": "Sonarr",
        "aliases": ["sonarr"],
        "packages": ["sonarr"],
        "config_dirs": ["~/.config/Sonarr", "~/Library/Application Support/Sonarr"],
        "important_files": ["config.xml", "sonarr.db"],
    },
    {
        "name": "radarr",
        "display": "Radarr",
        "aliases": ["radarr"],
        "packages": ["radarr"],
        "config_dirs": ["~/Library/Application Support/Radarr", "~/.config/Radarr"],
        "important_files": ["config.xml", "radarr.db"],
    },
    {
        "name": "prowlarr",
        "display": "Prowlarr",
        "aliases": ["prowlarr"],
        "packages": ["prowlarr"],
        "config_dirs": ["~/Library/Application Support/Prowlarr", "~/.config/Prowlarr"],
        "important_files": ["config.xml", "prowlarr.db"],
    },
    {
        "name": "bazarr",
        "display": "Bazarr",
        "aliases": ["bazarr"],
        "packages": ["bazarr"],
        "config_dirs": ["/opt/homebrew/var/bazarr", "~/.config/bazarr", "~/Library/Application Support/Bazarr"],
        "important_files": ["config/config.yaml", "db/bazarr.db"],
    },
    {
        "name": "jellyfin",
        "display": "Jellyfin",
        "aliases": ["jellyfin"],
        "packages": ["jellyfin"],
        "config_dirs": ["~/Library/Application Support/jellyfin", "~/.config/jellyfin"],
        "important_files": ["config/system.xml", "config/network.xml", "data/jellyfin.db", "data/library.db"],
    },
    {
        "name": "seerr",
        "display": "Seerr/Jellyseerr",
        "aliases": ["seerr", "jellyseerr"],
        "packages": ["jellyseerr", "overseerr"],
        "config_dirs": ["~/Library/Application Support/seerr", "~/Library/Application Support/jellyseerr"],
        "important_files": ["settings.json", "db/db.sqlite3"],
    },
    {
        "name": "transmission",
        "display": "Transmission",
        "aliases": ["transmission", "transmission-daemon", "transmission-cli"],
        "packages": ["transmission-cli", "transmission"],
        "config_dirs": ["/opt/homebrew/var/transmission", "~/Library/Application Support/Transmission", "~/.config/transmission"],
        "important_files": ["settings.json"],
    },
    {
        "name": "jackett",
        "display": "Jackett",
        "aliases": ["jackett"],
        "packages": ["jackett"],
        "config_dirs": ["~/Library/Application Support/Jackett", "~/.config/Jackett"],
        "important_files": ["ServerConfig.json", "Jackett/ServerConfig.json"],
    },
    {
        "name": "plex",
        "display": "Plex",
        "aliases": ["plex"],
        "packages": ["plex-media-server"],
        "config_dirs": ["~/Library/Application Support/Plex Media Server"],
        "important_files": [],
    },
    {
        "name": "emby",
        "display": "Emby",
        "aliases": ["emby"],
        "packages": ["emby-server"],
        "config_dirs": ["~/Library/Application Support/Emby-Server"],
        "important_files": [],
    },
    {
        "name": "qbittorrent",
        "display": "qBittorrent",
        "aliases": ["qbittorrent"],
        "packages": ["qbittorrent"],
        "config_dirs": ["~/.config/qBittorrent", "~/Library/Application Support/qBittorrent"],
        "important_files": [],
    },
    {
        "name": "sabnzbd",
        "display": "SABnzbd",
        "aliases": ["sabnzbd"],
        "packages": ["sabnzbd"],
        "config_dirs": ["~/.sabnzbd", "~/Library/Application Support/SABnzbd"],
        "important_files": [],
    },
    {
        "name": "lidarr",
        "display": "Lidarr",
        "aliases": ["lidarr"],
        "packages": ["lidarr"],
        "config_dirs": ["~/Library/Application Support/Lidarr", "~/.config/Lidarr"],
        "important_files": ["config.xml", "lidarr.db"],
    },
    {
        "name": "readarr",
        "display": "Readarr",
        "aliases": ["readarr"],
        "packages": ["readarr"],
        "config_dirs": ["~/Library/Application Support/Readarr", "~/.config/Readarr"],
        "important_files": ["config.xml", "readarr.db"],
    },
]

TEXT_EXTENSIONS = {
    ".txt", ".md", ".xml", ".json", ".yaml", ".yml", ".plist", ".py", ".sh", ".conf", ".ini", ".env", ".js", ".ts"
}
RAW_DB_EXTENSIONS = {".db", ".sqlite", ".sqlite3"}
EXCLUDED_DIR_NAMES = {
    ".git", "node_modules", ".next", "dist", "build", "cache", "Cache", "logs", "Logs", "transcodes", "metadata", "root", "Definitions"
}
SENSITIVE_KEYWORDS = re.compile(
    r"(api[_-]?key|apikey|token|secret|password|passwd|passphrase|credential|encryption[_-]?key|passkey|hashed_password|cookie|client[_-]?secret|rpc-password)",
    re.IGNORECASE,
)
APP_PATTERN = re.compile("|".join(sorted({re.escape(alias) for app in APP_DEFS for alias in app["aliases"]})), re.IGNORECASE)


def run_shell(command: str) -> dict[str, Any]:
    try:
        proc = subprocess.run(["/bin/sh", "-lc", command], capture_output=True, text=True)
        return {
            "command": command,
            "returncode": proc.returncode,
            "stdout": proc.stdout,
            "stderr": proc.stderr,
        }
    except Exception as exc:  # pragma: no cover
        return {"command": command, "returncode": 1, "stdout": "", "stderr": str(exc)}


def expand(path: str | Path) -> Path:
    return Path(path).expanduser().resolve()


def safe_read_text(path: Path) -> str | None:
    try:
        return path.read_text(encoding="utf-8", errors="replace")
    except Exception:
        return None


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def ensure_dir(path: Path) -> None:
    path.mkdir(parents=True, exist_ok=True)


def relativize(path: Path, base: Path) -> str:
    try:
        return str(path.resolve().relative_to(base.resolve()))
    except Exception:
        return str(path)


def is_textish(path: Path) -> bool:
    return path.suffix.lower() in TEXT_EXTENSIONS or path.name in {"config.xml", "settings.json", "package.json"}


def should_skip_dir(path: Path) -> bool:
    return path.name in EXCLUDED_DIR_NAMES


def sanitize_text(text: str) -> str:
    sensitive_field = r"(?:api[_-]?key|apikey|token|secret|password|passwd|passphrase|credential|encryption[_-]?key|passkey|hashed_password|cookie|client[_-]?secret|rpc-password)"
    patterns = [
        (re.compile(rf"(<([A-Za-z0-9_.:-]*{sensitive_field}[A-Za-z0-9_.:-]*)>)(.*?)(</\\2>)", re.IGNORECASE | re.DOTALL), r"\1REDACTED\4"),
        (re.compile(rf'("{sensitive_field}[^"]*"\s*:\s*")([^"]+)(")', re.IGNORECASE), r'\1REDACTED\3'),
        (re.compile(rf"^([ \t]*[A-Za-z0-9_.-]*{sensitive_field}[A-Za-z0-9_.-]*[ \t]*:[ \t]*)(.+)$", re.IGNORECASE | re.MULTILINE), r"\1REDACTED"),
        (re.compile(rf"^([ \t]*(?:export[ \t]+)?[A-Za-z0-9_.-]*{sensitive_field}[A-Za-z0-9_.-]*[ \t]*=[ \t]*)(.+)$", re.IGNORECASE | re.MULTILINE), r"\1REDACTED"),
    ]
    sanitized = text
    for pattern, repl in patterns:
        sanitized = pattern.sub(repl, sanitized)
    return sanitized


def copy_sanitized_text(src: Path, dest: Path) -> bool:
    text = safe_read_text(src)
    if text is None:
        return False
    ensure_dir(dest.parent)
    dest.write_text(sanitize_text(text), encoding="utf-8")
    return True


def copy_raw_file(src: Path, dest: Path) -> bool:
    try:
        ensure_dir(dest.parent)
        shutil.copy2(src, dest)
        return True
    except Exception:
        return False


def list_interesting_text_files(root: Path) -> list[Path]:
    files: list[Path] = []
    if not root.exists():
        return files
    if root.is_file():
        return [root] if is_textish(root) else []
    for current_root, dirnames, filenames in os.walk(root):
        current = Path(current_root)
        dirnames[:] = [d for d in dirnames if d not in EXCLUDED_DIR_NAMES]
        for filename in filenames:
            path = current / filename
            if is_textish(path):
                files.append(path)
    return sorted(files)


def list_raw_backup_files(root: Path) -> list[Path]:
    files: list[Path] = []
    if not root.exists():
        return files
    for current_root, dirnames, filenames in os.walk(root):
        dirnames[:] = [d for d in dirnames if d not in {"logs", "Logs", "cache", "Cache", "Definitions", ".git", "node_modules", ".next", "dist", "build"}]
        current = Path(current_root)
        for filename in filenames:
            path = current / filename
            suffix = path.suffix.lower()
            if is_textish(path) or suffix in RAW_DB_EXTENSIONS or path.name.endswith(".db-journal") or path.name.endswith(".db-wal") or path.name.endswith(".db-shm"):
                files.append(path)
    return sorted(files)


def find_default_target() -> Path:
    candidates = [expand("~/Server/media-server"), Path.cwd()]
    for candidate in candidates:
        if candidate.exists():
            return candidate
    return Path.cwd()


def find_compose_files(target_root: Path) -> list[Path]:
    names = {"compose.yml", "compose.yaml", "docker-compose.yml", "docker-compose.yaml", "stack.yml", "stack.yaml"}
    results: list[Path] = []
    for current_root, dirnames, filenames in os.walk(target_root):
        current = Path(current_root)
        try:
            depth = len(current.relative_to(target_root).parts)
        except Exception:
            depth = 0
        if depth > 5:
            dirnames[:] = []
            continue
        dirnames[:] = [d for d in dirnames if d not in {".git", "node_modules", ".next", "dist", "build", "cache"}]
        for filename in filenames:
            if filename in names:
                results.append(current / filename)
    return sorted(results)


def find_project_paths(target_root: Path) -> dict[str, list[Path]]:
    mapping: dict[str, list[Path]] = {
        "docs": [],
        "scripts": [],
        "boot_daemons": [],
        "credentials": [],
        "compose_files": [],
        "seerr_project_files": [],
    }
    docs_dir = target_root / "docs"
    scripts_dir = target_root / "scripts"
    boot_daemons_dir = target_root / "boot-daemons"
    credentials_dir = target_root / "credentials"
    seerr_dir = target_root / "seerr"

    if docs_dir.exists():
        mapping["docs"] = list_interesting_text_files(docs_dir)
    if scripts_dir.exists():
        mapping["scripts"] = list_interesting_text_files(scripts_dir)
    if boot_daemons_dir.exists():
        mapping["boot_daemons"] = list_interesting_text_files(boot_daemons_dir)
    if credentials_dir.exists():
        mapping["credentials"] = sorted([p for p in credentials_dir.iterdir() if p.is_file()])
    mapping["compose_files"] = find_compose_files(target_root)

    if seerr_dir.exists():
        for rel in ["compose.yaml", "docker-compose.yml", "docker-compose.yaml", "package.json", "README.md"]:
            path = seerr_dir / rel
            if path.exists():
                mapping["seerr_project_files"].append(path)
    return mapping


def parse_first_level_xml(path: Path) -> dict[str, Any] | None:
    try:
        root = ET.parse(path).getroot()
    except Exception:
        return None
    parsed: dict[str, Any] = {}
    for child in list(root):
        tag = child.tag
        text = (child.text or "").strip()
        if list(child):
            nested = {grand.tag: ((grand.text or "").strip() if not SENSITIVE_KEYWORDS.search(grand.tag) else "REDACTED") for grand in list(child)}
            parsed[tag] = nested
        else:
            parsed[tag] = "REDACTED" if SENSITIVE_KEYWORDS.search(tag) else text
    return parsed


def parse_json_summary(path: Path) -> dict[str, Any] | None:
    try:
        data = json.loads(path.read_text(encoding="utf-8", errors="replace"))
    except Exception:
        return None

    def scrub(value: Any, parent_key: str = "") -> Any:
        if isinstance(value, dict):
            out: dict[str, Any] = {}
            for key, item in value.items():
                if SENSITIVE_KEYWORDS.search(key):
                    out[key] = "REDACTED"
                elif isinstance(item, (dict, list)):
                    out[key] = scrub(item, key)
                elif key.lower() in {"hostname", "host", "port", "baseurl", "url", "download-dir", "watch-dir", "rpc-port", "rpc-url"}:
                    out[key] = item
            return out
        if isinstance(value, list):
            return [scrub(item, parent_key) for item in value[:10]]
        return value

    return scrub(data)


def parse_plist_summary(path: Path) -> dict[str, Any] | None:
    try:
        with path.open("rb") as f:
            data = plistlib.load(f)
    except Exception:
        return None
    summary: dict[str, Any] = {}
    for key in ["Label", "Program", "ProgramArguments", "WorkingDirectory", "RunAtLoad", "KeepAlive", "StandardOutPath", "StandardErrorPath"]:
        if key in data:
            summary[key] = data[key]
    env = data.get("EnvironmentVariables")
    if isinstance(env, dict):
        clean_env = {k: ("REDACTED" if SENSITIVE_KEYWORDS.search(k) else v) for k, v in env.items()}
        summary["EnvironmentVariables"] = clean_env
    return summary


def parse_transmission_settings(path: Path) -> dict[str, Any] | None:
    try:
        data = json.loads(path.read_text(encoding="utf-8", errors="replace"))
    except Exception:
        return None
    keys = [
        "download-dir", "incomplete-dir", "incomplete-dir-enabled", "watch-dir", "watch-dir-enabled",
        "rpc-bind-address", "rpc-port", "rpc-authentication-required", "rpc-username",
        "peer-port", "trash-original-torrent-files", "seed-queue-enabled"
    ]
    out = {}
    for key in keys:
        if key in data:
            out[key] = "REDACTED" if SENSITIVE_KEYWORDS.search(key) else data[key]
    if "rpc-password" in data:
        out["rpc-password"] = "REDACTED"
    return out


def parse_bazarr_summary(path: Path) -> dict[str, Any] | None:
    text = safe_read_text(path)
    if text is None:
        return None

    summary: dict[str, Any] = {}
    current_section: str | None = None
    collecting_list_for: str | None = None

    interesting = {
        "general": {
            "ip", "port", "base_url", "enabled_providers", "use_sonarr", "use_radarr",
            "movie_default_profile", "serie_default_profile", "movie_tag_enabled", "serie_tag_enabled",
            "remove_profile_tags"
        },
        "auth": {"type", "apikey"},
        "sonarr": {"ip", "port", "base_url", "ssl", "apikey"},
        "radarr": {"ip", "port", "base_url", "ssl", "apikey"},
    }

    for raw_line in text.splitlines():
        line = raw_line.rstrip()
        if not line or line.lstrip().startswith("#"):
            continue

        section_match = re.match(r"^([A-Za-z0-9_]+):\s*$", line)
        if section_match and not line.startswith(" "):
            current_section = section_match.group(1)
            collecting_list_for = None
            continue

        if not current_section or current_section not in interesting:
            continue

        key_match = re.match(r"^  ([A-Za-z0-9_\-]+):\s*(.*)$", line)
        if key_match:
            key = key_match.group(1)
            value = key_match.group(2).strip()
            if key not in interesting[current_section]:
                collecting_list_for = None
                continue
            if value == "":
                summary.setdefault(current_section, {})[key] = []
                collecting_list_for = key
            else:
                summary.setdefault(current_section, {})[key] = "REDACTED" if SENSITIVE_KEYWORDS.search(key) else value
                collecting_list_for = None
            continue

        if collecting_list_for and re.match(r"^  - ", line):
            item = line[4:].strip()
            summary.setdefault(current_section, {}).setdefault(collecting_list_for, []).append(item)

    return summary or None


def app_config_summary(app_name: str, config_dirs: list[Path]) -> dict[str, Any]:
    summary: dict[str, Any] = {}
    for config_dir in config_dirs:
        if not config_dir.exists():
            continue
        if app_name in {"sonarr", "radarr", "prowlarr", "lidarr", "readarr"}:
            config_file = config_dir / "config.xml"
            if config_file.exists():
                summary[config_file.name] = parse_first_level_xml(config_file)
        elif app_name == "jellyfin":
            for rel in ["config/system.xml", "config/network.xml", "config/encoding.xml", "plugins/configurations/Trakt.xml"]:
                path = config_dir / rel
                if path.exists():
                    summary[rel] = parse_first_level_xml(path)
        elif app_name == "seerr":
            settings = config_dir / "settings.json"
            if settings.exists():
                summary[settings.name] = parse_json_summary(settings)
        elif app_name == "transmission":
            settings = config_dir / "settings.json"
            if settings.exists():
                summary[settings.name] = parse_transmission_settings(settings)
        elif app_name == "bazarr":
            config_file = config_dir / "config" / "config.yaml"
            if config_file.exists():
                summary[str(config_file.relative_to(config_dir))] = parse_bazarr_summary(config_file)
        else:
            for file_name in ["config.xml", "settings.json"]:
                path = config_dir / file_name
                if path.exists():
                    if path.suffix == ".xml":
                        summary[file_name] = parse_first_level_xml(path)
                    else:
                        summary[file_name] = parse_json_summary(path)
    return {k: v for k, v in summary.items() if v}


def filter_matching_lines(text: str, aliases: list[str]) -> list[str]:
    lines = []
    alias_re = re.compile("|".join(re.escape(a) for a in aliases), re.IGNORECASE)
    for line in text.splitlines():
        if alias_re.search(line):
            lines.append(line.rstrip())
    return lines


def detect_launch_files(target_root: Path, aliases: list[str]) -> list[Path]:
    roots = [
        expand("~/Library/LaunchAgents"),
        expand("~/Library/LaunchAgents.disabled"),
        target_root / "boot-daemons",
        expand("~/Library/LaunchDaemons-staging"),
    ]
    results: list[Path] = []
    alias_re = re.compile("|".join(re.escape(a) for a in aliases), re.IGNORECASE)
    allowed_suffixes = (".plist", ".plist.disabled")
    for root in roots:
        if not root.exists():
            continue
        if root.is_file() and alias_re.search(root.name) and root.name.endswith(allowed_suffixes):
            results.append(root)
            continue
        for current_root, _, filenames in os.walk(root):
            current = Path(current_root)
            for filename in filenames:
                path = current / filename
                if alias_re.search(filename) and filename.endswith(allowed_suffixes):
                    results.append(path)
    return sorted(set(results))


def homebrew_versions() -> dict[str, str]:
    result = run_shell("command -v brew >/dev/null 2>&1 && brew list --versions || true")
    versions: dict[str, str] = {}
    for line in result["stdout"].splitlines():
        parts = line.split()
        if len(parts) >= 2:
            versions[parts[0]] = " ".join(parts[1:])
    return versions


def command_output_bundle() -> dict[str, dict[str, Any]]:
    commands = {
        "hostname": "hostname",
        "uname": "uname -a",
        "sw_vers": "sw_vers 2>/dev/null || true",
        "brew_services": "command -v brew >/dev/null 2>&1 && brew services list || true",
        "brew_versions": "command -v brew >/dev/null 2>&1 && brew list --versions || true",
        "launchctl_media": "launchctl list 2>/dev/null | egrep -i 'sonarr|radarr|prowlarr|bazarr|jellyfin|seerr|jellyseerr|transmission|jackett|plex|emby|qbittorrent|sabnzbd|lidarr|readarr' || true",
        "ps_media": "ps aux | egrep -i 'sonarr|radarr|prowlarr|bazarr|jellyfin|seerr|jellyseerr|transmission|jackett|plex|emby|qbittorrent|sabnzbd|lidarr|readarr' | grep -v egrep || true",
        "ports_media": "lsof -nP -iTCP -sTCP:LISTEN 2>/dev/null | egrep -i 'sonarr|radarr|prowlarr|bazarr|jellyfin|seerr|jellyseerr|transmission|jackett|plex|emby|qbittorrent|sabnzbd|lidarr|readarr' || true",
        "docker_ps": "command -v docker >/dev/null 2>&1 && docker ps --format '{{json .}}' || true",
        "docker_compose_ls": "command -v docker >/dev/null 2>&1 && docker compose ls || true",
        "applications": "ls -1 /Applications 2>/dev/null | egrep 'Sonarr|Radarr|Prowlarr|Jellyfin|Plex|Emby' || true",
    }
    return {name: run_shell(cmd) for name, cmd in commands.items()}


def detect_apps(target_root: Path, commands: dict[str, dict[str, Any]], brew_versions_map: dict[str, str]) -> list[dict[str, Any]]:
    detected: list[dict[str, Any]] = []
    ps_text = commands["ps_media"]["stdout"]
    ports_text = commands["ports_media"]["stdout"]

    for app in APP_DEFS:
        config_dirs = [expand(p) for p in app["config_dirs"] if expand(p).exists()]
        launch_files = detect_launch_files(target_root, app["aliases"])
        running_lines = filter_matching_lines(ps_text, app["aliases"])
        port_lines = filter_matching_lines(ports_text, app["aliases"])
        package_versions = {pkg: brew_versions_map[pkg] for pkg in app["packages"] if pkg in brew_versions_map}

        important_files: list[str] = []
        for config_dir in config_dirs:
            for rel in app.get("important_files", []):
                path = config_dir / rel
                if path.exists():
                    important_files.append(str(path))

        if not (config_dirs or launch_files or running_lines or port_lines or package_versions):
            continue

        detected.append(
            {
                "name": app["name"],
                "display": app["display"],
                "aliases": app["aliases"],
                "configDirs": [str(p) for p in config_dirs],
                "importantFiles": sorted(set(important_files)),
                "launchFiles": [str(p) for p in launch_files],
                "runningProcesses": running_lines,
                "listeningPorts": port_lines,
                "brewPackages": package_versions,
                "configSummary": app_config_summary(app["name"], config_dirs),
            }
        )
    return detected


def write_command_outputs(output_dir: Path, commands: dict[str, dict[str, Any]]) -> None:
    commands_dir = output_dir / "commands"
    ensure_dir(commands_dir)
    for name, result in commands.items():
        text = []
        text.append(f"$ {result['command']}")
        text.append("")
        if result["stdout"]:
            text.append(result["stdout"].rstrip())
        if result["stderr"]:
            text.append("")
            text.append("[stderr]")
            text.append(result["stderr"].rstrip())
        text.append("")
        (commands_dir / f"{name}.txt").write_text("\n".join(text), encoding="utf-8")


def collect_sanitized_files(target_root: Path, project_paths: dict[str, list[Path]], apps: list[dict[str, Any]], output_dir: Path) -> list[str]:
    copied: list[str] = []
    sanitized_root = output_dir / "sanitized"

    project_groups = {
        "docs": sanitized_root / "project" / "docs",
        "scripts": sanitized_root / "project" / "scripts",
        "boot_daemons": sanitized_root / "project" / "boot-daemons",
        "compose_files": sanitized_root / "project" / "compose",
        "seerr_project_files": sanitized_root / "project" / "seerr-project",
    }

    for group, dest_root in project_groups.items():
        for src in project_paths.get(group, []):
            rel_name = src.name if group != "compose_files" else relativize(src, target_root).replace("/", "__")
            dest = dest_root / rel_name
            if copy_sanitized_text(src, dest):
                copied.append(str(dest.relative_to(output_dir)))

    for app in apps:
        app_root = sanitized_root / "apps" / app["name"]
        for config_dir_str in app["configDirs"]:
            config_dir = Path(config_dir_str)
            source_root_name = re.sub(r"[^A-Za-z0-9._-]+", "_", str(config_dir).strip("/"))
            for src in list_interesting_text_files(config_dir):
                rel = src.relative_to(config_dir)
                dest = app_root / source_root_name / rel
                if copy_sanitized_text(src, dest):
                    copied.append(str(dest.relative_to(output_dir)))
        for launch_file in app["launchFiles"]:
            src = Path(launch_file)
            if src.exists() and is_textish(src):
                dest = app_root / "launchd" / src.name
                if copy_sanitized_text(src, dest):
                    copied.append(str(dest.relative_to(output_dir)))

    return sorted(set(copied))


def collect_sensitive_files(project_paths: dict[str, list[Path]], apps: list[dict[str, Any]], output_dir: Path) -> list[str]:
    copied: list[str] = []
    sensitive_root = output_dir / "sensitive"

    for src in project_paths.get("credentials", []):
        dest = sensitive_root / "credentials" / src.name
        if copy_raw_file(src, dest):
            copied.append(str(dest.relative_to(output_dir)))

    for app in apps:
        app_root = sensitive_root / "apps" / app["name"]
        for config_dir_str in app["configDirs"]:
            config_dir = Path(config_dir_str)
            source_root_name = re.sub(r"[^A-Za-z0-9._-]+", "_", str(config_dir).strip("/"))
            for src in list_raw_backup_files(config_dir):
                rel = src.relative_to(config_dir)
                dest = app_root / source_root_name / rel
                if copy_raw_file(src, dest):
                    copied.append(str(dest.relative_to(output_dir)))
    return sorted(set(copied))


def build_checksums(output_dir: Path) -> list[str]:
    lines: list[str] = []
    for root_name in ["sanitized", "sensitive"]:
        root = output_dir / root_name
        if not root.exists():
            continue
        for path in sorted(p for p in root.rglob("*") if p.is_file()):
            lines.append(f"{sha256(path)}  {path.relative_to(output_dir)}")
    return lines


def gather_host_summary() -> dict[str, Any]:
    summary = {
        "hostname": socket.gethostname(),
        "generatedAt": datetime.now().astimezone().isoformat(),
        "platform": sys.platform,
        "cwd": str(Path.cwd()),
    }
    sw = run_shell("sw_vers 2>/dev/null || true")
    if sw["stdout"].strip():
        summary["sw_vers"] = sw["stdout"].strip().splitlines()
    return summary


def render_report(output_dir: Path, target_root: Path, host: dict[str, Any], apps: list[dict[str, Any]], project_paths: dict[str, list[Path]], manifest: dict[str, Any], include_sensitive: bool) -> str:
    lines: list[str] = []
    lines.append("# Media server reproducibility report")
    lines.append("")
    lines.append(f"Generated: {host['generatedAt']}")
    lines.append(f"Target root: `{target_root}`")
    lines.append(f"Host: `{host['hostname']}`")
    lines.append("")

    lines.append("## Detected applications")
    lines.append("")
    if not apps:
        lines.append("No known media-server applications were detected.")
    else:
        for app in apps:
            lines.append(f"### {app['display']}")
            lines.append("")
            if app["configDirs"]:
                lines.append("- Config dirs:")
                for item in app["configDirs"]:
                    lines.append(f"  - `{item}`")
            if app["importantFiles"]:
                lines.append("- Important files:")
                for item in app["importantFiles"]:
                    lines.append(f"  - `{item}`")
            if app["brewPackages"]:
                lines.append("- Homebrew packages:")
                for pkg, version in app["brewPackages"].items():
                    lines.append(f"  - `{pkg}`: `{version}`")
            if app["launchFiles"]:
                lines.append("- launchd files:")
                for item in app["launchFiles"]:
                    lines.append(f"  - `{item}`")
            if app["listeningPorts"]:
                lines.append("- Listening ports/process lines:")
                for item in app["listeningPorts"][:5]:
                    lines.append(f"  - `{item}`")
            if app["runningProcesses"]:
                lines.append("- Running process lines:")
                for item in app["runningProcesses"][:5]:
                    lines.append(f"  - `{item}`")
            if app["configSummary"]:
                lines.append("- Parsed config summary:")
                preview = json.dumps(app["configSummary"], indent=2, ensure_ascii=False)
                if len(preview) > 1800:
                    preview = preview[:1800].rstrip() + "\n... truncated, see sanitized files and manifest.json for full detail ..."
                lines.append("```json")
                lines.append(preview)
                lines.append("```")
            lines.append("")

    lines.append("## Project files captured")
    lines.append("")
    for label, key in [("Docs", "docs"), ("Scripts", "scripts"), ("Boot daemons", "boot_daemons"), ("Compose files", "compose_files"), ("Seerr project files", "seerr_project_files")]:
        values = project_paths.get(key, [])
        lines.append(f"- {label}: {len(values)}")
        for item in values[:20]:
            lines.append(f"  - `{item}`")
    if project_paths.get("credentials"):
        lines.append(f"- Credential files detected: {len(project_paths['credentials'])} (names only in sanitized mode)")
        for item in project_paths["credentials"][:20]:
            lines.append(f"  - `{item.name}`")
    lines.append("")

    lines.append("## Bundle contents")
    lines.append("")
    lines.append("- `manifest.json`")
    lines.append("- `commands/`")
    lines.append("- `sanitized/`")
    if include_sensitive:
        lines.append("- `sensitive/` (private backup material; do not commit)")
    lines.append("")

    lines.append("## Reproduction guidance")
    lines.append("")
    lines.append("1. Install the detected applications and matching service definitions.")
    lines.append("2. Recreate launchd/Homebrew/Docker wiring from the captured plist and compose files.")
    lines.append("3. Recreate media/storage paths and downloader paths from app configs.")
    lines.append("4. Reapply helper scripts and scheduled tasks from `sanitized/project/scripts/` and `sanitized/project/boot-daemons/`.")
    lines.append("5. If a full migration is required, use the raw files in `sensitive/` on a private machine only.")
    lines.append("")

    warnings = manifest.get("warnings") or []
    if warnings:
        lines.append("## Warnings")
        lines.append("")
        for warning in warnings:
            lines.append(f"- {warning}")
        lines.append("")

    return "\n".join(lines).rstrip() + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description="Collect a reproducibility snapshot for a local media server stack.")
    parser.add_argument("--target-root", default=None, help="Media-server project root. Defaults to ~/Server/media-server when present.")
    parser.add_argument("--output", default=None, help="Output directory. Defaults to <target-root>/inventory-reports/<timestamp>.")
    parser.add_argument("--include-sensitive", action="store_true", help="Copy raw config/db/credential material into sensitive/.")
    args = parser.parse_args()

    target_root = expand(args.target_root) if args.target_root else find_default_target()
    timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    output_dir = expand(args.output) if args.output else target_root / "inventory-reports" / timestamp
    ensure_dir(output_dir)
    (output_dir / ".gitignore").write_text("sensitive/\n", encoding="utf-8")

    host = gather_host_summary()
    commands = command_output_bundle()
    write_command_outputs(output_dir, commands)
    brew_versions_map = homebrew_versions()
    project_paths = find_project_paths(target_root)
    apps = detect_apps(target_root, commands, brew_versions_map)
    sanitized_files = collect_sanitized_files(target_root, project_paths, apps, output_dir)
    sensitive_files = collect_sensitive_files(project_paths, apps, output_dir) if args.include_sensitive else []
    checksums = build_checksums(output_dir)
    (output_dir / "checksums.txt").write_text("\n".join(checksums) + ("\n" if checksums else ""), encoding="utf-8")

    warnings = []
    if project_paths.get("credentials") and not args.include_sensitive:
        warnings.append("Credential files were detected but not copied. Re-run with --include-sensitive for a private migration bundle.")
    if any(app.get("configDirs") for app in apps) and not args.include_sensitive:
        warnings.append("App databases may contain UI-only settings. Sanitized mode copies readable config files but not raw databases.")

    manifest = {
        "host": host,
        "targetRoot": str(target_root),
        "outputDir": str(output_dir),
        "apps": apps,
        "projectFiles": {k: [str(p) for p in v] for k, v in project_paths.items()},
        "artifacts": {
            "sanitizedFiles": sanitized_files,
            "sensitiveFiles": sensitive_files,
            "commandFiles": sorted(str(p.relative_to(output_dir)) for p in (output_dir / "commands").glob("*.txt")),
            "checksums": "checksums.txt",
        },
        "warnings": warnings,
    }
    (output_dir / "manifest.json").write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    report = render_report(output_dir, target_root, host, apps, project_paths, manifest, args.include_sensitive)
    (output_dir / "REPORT.md").write_text(report, encoding="utf-8")

    print(output_dir)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
