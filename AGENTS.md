# Repository guidance

This repository stores personal dotfiles shared across Linux, macOS, and Windows. Keep changes small, portable where practical, and easy to review.

## Repository layout

- `common/` contains configuration shared across operating systems.
- `linux/`, `mac-os/`, and `windows/` contain platform-specific configuration and package lists.
- `.mappings` is the source of truth for links from repository files to their installed locations.
- More specific instructions in nested `AGENTS.md` files take precedence within their directories.

## Working practices

- Read the relevant platform README and existing configuration before editing.
- Preserve unrelated local changes and the existing style, ordering, comments, and formatting.
- Prefer the smallest change that satisfies the request; avoid speculative abstractions or broad cleanup.
- Put cross-platform configuration in `common/` and platform-only behavior in the corresponding OS directory.
- Do not commit secrets, tokens, credentials, host-specific identifiers, or private paths. Use ignored local overrides for machine-specific shell configuration.
- Update documentation when setup commands, required packages, mappings, or user-visible behavior change.

## Editor shortcuts

- Treat a request to add, change, or remove a shortcut in one IDE as a request to make the equivalent change in every configured IDE.
- Keep `common/cursor/keybindings.json`, `common/vscode/keybindings.json`, and `common/zed/keymap.json` synchronized.
- Translate commands and context conditions into each editor's native syntax instead of copying entries verbatim.
- If an editor has no equivalent command or cannot express the same condition, leave its configuration valid and clearly report the limitation.

## Configuration conventions

- Keep package manifests as one package per line and preserve their established naming and ordering conventions.
- Use Fish syntax for `.fish` files and PowerShell syntax for `.ps1` files; do not assume shell behavior is interchangeable.
- Preserve JSON/JSONC and TOML conventions used by the target application, including comments where supported.
- When adding a managed file, update `.mappings` for every platform where it should be installed.

## Verification

- Run focused syntax or configuration checks for files changed when the relevant tool is available.
- Use `fish -n` for Fish scripts.
- Run `dot -v check` after changing `.mappings` or managed paths when it is safe to check the current host.
- Do not install/remove packages, initialize dotfiles, or otherwise mutate the host system merely to verify a change unless explicitly requested.
- Report checks that were run and any platform-specific behavior that could not be verified locally.
