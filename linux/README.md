# Linux (Arch Linux)
Dotfiles for Arch Linux enviroment.

- Terminal:
  - [Alacritty](https://alacritty.org/) as terminal
  - [Starship](https://starship.rs/) as prompt
  - Fish as shell

![Terminal](assets/terminal.png)

- IDE:
  - [VS Code Insiders](https://code.visualstudio.com/insiders/) as IDE
  - Terminal is also using Starship and Fish

![VS Code](assets/vscode.png)

## Makefile
### Targets
* `git`: Configures git
* `install-packages`: Installs all the packages
* `network`: Configures Google DNS
* `probe-rs`: Configures probe-rs udev rules (https://probe.rs/docs/getting-started/probe-setup/#udev-rules)
* `remove-packages`: Removes unnecessary packages installed with gnome
* `rust`: Configures Rust aliases and installs crates
* `shell`: Configures Fish
* `terminal`: Configures Alacritty
* `vscode`: Configures VS Code settings
  > **Note**
  > This is step is not required since loging into VS Code syncs keybingins and settings.

