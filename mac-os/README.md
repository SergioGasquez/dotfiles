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
5. Install the extra crates, preserving any arguments on each line:
   ```bash
   while IFS= read -r line; do
       read -r -a crate_args <<< "$line"
       cargo install "${crate_args[@]}"
   done < ../common/rust/crates
   ```
6. Install the Espressif Rust toolchains and generate the export file used by
   Fish:
   ```bash
   espup install
   ```
7. Install [Pi](https://pi.dev/docs/latest/quickstart#install):
   ```bash
   npm install -g --ignore-scripts @earendil-works/pi-coding-agent
   ```
8. Regenerate the Fish completions:
   ```bash
   espup completions fish > ../common/shell/espup.fish
   espflash completions fish > ../common/shell/espflash.fish
   ```
9. Check that all managed links are correct:
   ```bash
   dot -v check
   ```

## Remote probe-rs

`$HOME/.probe-rs.toml` defines `<chip>-hil` presets that connect to
`ssh://hil-<chip>:3000`. Keep the private details out of this repository:

- Define each `hil-<chip>` host alias, with its user and jump host, in
  `~/.ssh/config`.
- If the runners require a token, set `PROBE_RS_REMOTE_TOKEN` in the ignored
  `mac-os/shell/espressif.fish`.

Then run `probe-rs <command> --preset esp32c6-hil`, or set
`PROBE_RS_CONFIG_PRESET` for tools such as `esp-devtool`.
