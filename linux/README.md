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

## Setup Dotfiles

1. [Install Rust](https://www.rust-lang.org/tools/install)
    ```
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    ```
2. Install extra crates:
    ```
    cat ../common/rust/crates | while IFS= read -r line; do read -r crate arguments <<< "$$line"; cargo install "$$crate" $$arguments; done
    ```
3. Install extra packages:
    ```
    paru --needed -S - < packages
    ```
4. Remove unnecessary packages:
    ```
    paru --noconfirm -R - < packages-to-delete
    ```
5. Initialize dotfiles and check if all the links exist and are correct
    ```
    dot init SergioGasquez/dotfiles
    dot check
    ```
