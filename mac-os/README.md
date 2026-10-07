# macOS
Dotfiles for macOS environment.

- Terminal:
  - [Warp](https://www.warp.dev/) and [Ghostty](https://ghostty.org/) as terminals
  - Fish as shell

![Terminal](assets/terminal.png)

Ghostty's config is shared with Linux from `common/ghostty/config`, managed at
`~/.config/ghostty/config`, and uses native macOS window decorations. Ghostty
launches the login shell, so set Homebrew's Fish as the login shell. The
Linux-only GTK options in the shared config are ignored on macOS.
Ghostty's default macOS shortcuts already use `Cmd` (for example `Cmd+C`,
`Cmd+V`, `Cmd+T`).

- IDE:
  - [Zed](https://zed.dev/) as the default IDE, with [Cursor](https://www.cursor.com/) also installed
  - Terminal is also using Starship and Fish

![Cursor and Zed](assets/vscode.png)

## Setup Dotfiles

Run these commands in Bash. The repository is installed at `$HOME/.dotfiles`.

1. [Install Homebrew](https://brew.sh/) and follow the PATH instructions printed
   by the installer:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
2. [Install Rust](https://www.rust-lang.org/tools/install):
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   source "$HOME/.cargo/env"
   ```
3. Install `dot`, initialize the repository, and enter the macOS directory:
   ```bash
   cargo install --git https://github.com/ubnt-intrepid/dot.git
   dot init SergioGasquez/dotfiles
   cd "$HOME/.dotfiles/mac-os"
   ```
4. Install the system packages before building the remaining Rust tools:
   ```bash
   while IFS= read -r package; do
       [ -n "$package" ] && brew install "$package"
   done < packages
   ```
5. Continue with the [Linux and macOS setup](../README.md#linux-and-macos-setup).
