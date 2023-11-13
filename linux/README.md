# Linux (Arch Linux)

I use:
- Terminal:
  - [Alacritty](https://alacritty.org/) as terminal
  - [Starship](https://starship.rs/) as prompt
  - Fish as shell

![Terminal](assets/terminal.png)

- IDE:
  - [VsCode Insiders](https://code.visualstudio.com/insiders/) as IDE
  - Terminal is also using Starship and Fish

![VsCode](assets/vscode.png)

## Makefile
### Targets
* `git`: Configures git
* `install-packages`: Installs all the packages
* `network`: Configures Google DNS
* `remove-packages`: Removes unnecessary packages installed with gnome
* `rust`: Configures Rust aliases and installs crates
* `shell`: Configures Fish
* `terminal`: Configures Alacritty
* `vscode`: Configures VS Code settings
  * > **Note**
    > This is step is not really required since loging into VsCode syncs keybingins and settings.
