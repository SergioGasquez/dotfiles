# Linux (Arch Linux)
Dotfiles for Arch Linux environment.

- Terminal:
  - [Ghostty](https://ghostty.org/) as terminal
  - [Starship](https://starship.rs/) as prompt
  - Fish as shell

![Terminal](assets/terminal.png)

Ghostty's config is shared with macOS from `common/ghostty/config`, managed at
`~/.config/ghostty/config`, based on
[davidgasquez/dotfiles](https://github.com/davidgasquez/dotfiles/blob/main/terminal/ghostty/config),
and uses a GTK title bar and window controls. Ghostty launches the login shell,
so set Fish with `chsh -s /usr/bin/fish`. New Ghostty windows start in the home
directory; tabs and splits can still inherit their parent directory. Press
`Ctrl+W` to close the current Ghostty tab.
After linking with `dot`, install Ghostty with `paru --needed -S ghostty` if
not installing the full package list.

[herdr](https://herdr.dev/) settings and keybindings are shared with macOS from
`common/herdr/config.toml`, managed at `~/.config/herdr/config.toml`. Apply
edits to a running session with `herdr server reload-config`.

Install the herdr TUI, then the Herdr app, which also installs herdr-core
(`hc`). All three go into `~/.local/bin`:

```bash
curl -fsSL https://herdr.dev/install.sh | sh
curl -fsSL https://releases.herdr.dev/app/install.sh | sh
```

`herdr update` updates the TUI and `hc update` updates herdr-core; the app
keeps herdr-core current, and rerunning its installer updates the app.

- IDE:
  - [Zed](https://zed.dev/) as the default IDE, with [Cursor](https://www.cursor.com/) also installed
  - Terminal is also using Starship and Fish

![Cursor and Zed](assets/vscode.png)

## Setup Dotfiles

This setup assumes the Linux steps in the
[Installation Guide](../InstallationGuide.md) are complete. Run these commands
in Bash. The repository is installed at `$HOME/.dotfiles`.

1. [Install Rust](https://www.rust-lang.org/tools/install):
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   source "$HOME/.cargo/env"
   ```
2. Install `dot`, initialize the repository, and enter the Linux directory:
   ```bash
   cargo install --git https://github.com/ubnt-intrepid/dot.git
   dot init SergioGasquez/dotfiles
   cd "$HOME/.dotfiles/linux"
   ```
3. Install the system packages before building the remaining Rust tools:
   ```bash
   paru --needed -S - < packages
   ```
4. Remove the unwanted packages that are installed (`-R` aborts on any
   missing target):
   ```bash
   comm -12 <(pacman -Qq | sort) <(sort packages-to-delete) | paru --noconfirm -R -
   ```
5. Continue with the [Linux and macOS setup](../README.md#linux-and-macos-setup).
