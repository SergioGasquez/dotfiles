# Repository guidance

This repository stores personal dotfiles shared across Linux, macOS, and Windows.

## Repository layout

- `common/` contains configuration shared across operating systems.
- `linux/`, `mac-os/`, and `windows/` contain platform-specific configuration and package lists.
- `.mappings` is the source of truth for links from repository files to their installed locations.

## Working practices

- Use the relevant platform README for setup, package, or platform behavior changes.
- Put cross-platform configuration in `common/` and platform-only behavior in the corresponding OS directory.
- Do not commit secrets, tokens, credentials, host-specific identifiers, or private paths. Use ignored local overrides for machine-specific shell configuration.
- Update documentation when setup commands, required packages, mappings, or user-visible behavior change.

## Editor shortcuts

- Treat a request to add, change, or remove a shortcut in one IDE as a request to make the equivalent change in every configured IDE.
- Keep `common/cursor/keybindings.json`, `common/vscode/keybindings.json`, and `common/zed/keymap.json` synchronized.
- Keep shortcuts cross-platform: every custom `Ctrl` binding for Linux and Windows must also have an equivalent `Command` binding for macOS.
- Translate commands and context conditions into each editor's native syntax instead of copying entries verbatim.
- If an editor has no equivalent command or cannot express the same condition, leave its configuration valid and clearly report the limitation.

## Configuration conventions

- Keep package manifests as one package per line and preserve their established naming and ordering conventions.
- When adding a managed file, update `.mappings` for every platform where it should be installed.

## Verification

- Use `fish -n` for changed Fish scripts.
- Run `dot -v check` after changing `.mappings` or managed paths when it is safe to check the current host.
- For implementation, continue through scoped edits, relevant local checks, and fixes to regressions introduced by the change until the requested behavior works or a material decision blocks progress. Managed files may be symlinked into active configuration; source edits can take immediate effect.
- Do not install/remove packages, initialize dotfiles, relink managed files, restart services, or otherwise change host setup merely to verify a change unless explicitly requested.
- Report checks that were run and any platform-specific behavior that could not be verified locally.
