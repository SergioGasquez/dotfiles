# Linux (Arch Linux)
Dotfiles for Arch Linux environment.

- Terminal:
  - [Alacritty](https://alacritty.org/) as terminal
  - [Starship](https://starship.rs/) as prompt
  - Fish as shell

![Terminal](assets/terminal.png)

- IDE:
  - [VS Code](https://code.visualstudio.com/) as IDE
  - Terminal is also using Starship and Fish

![VS Code](assets/vscode.png)

## Makefile
### Targets
* `dot`: Configures dotfiles symlinks
  * Needs to be executed after `rust`
* `install-packages`: Installs all the packages
* `remove-packages`: Removes unnecessary packages installed with gnome
* `rust`: Installs Rust and crates
* `udev`: Configures OpenOCD (https://docs.espressif.com/projects/esp-idf/en/release-v5.1/esp32c2/api-guides/jtag-debugging/configure-other-jtag.html) and probe-rs(https://probe.rs/docs/getting-started/probe-setup/#udev-rules) udev rules
