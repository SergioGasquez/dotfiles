# Windows
Dotfiles for my Windows enviroment.

I use:
- Terminal:
  - [Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=es-es&gl=es) as terminal
  - [Starship](https://starship.rs/) as prompt
  - Powershell as shell

![Terminal](assets/terminal.png)

- IDE:
  - [VsCode Insiders](https://code.visualstudio.com/insiders/) as IDE
  - Terminal is also using Starship and Powershell

![VsCode](assets/vscode.png)

## Starship
1. Install `winget`
2. Install Starship
    ```powershell
    winget install --id Starship.Starship
    ```
3. Create symbolic link for $PROFILE (Use privileged terminal)
    ```powershell
    New-Item -ItemType SymbolicLink -Path .\shell\Microsoft.PowerShell_profile.ps1 -Target  C:\Users\sergi\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
    ```

## Rust
1. [Install Rust](https://www.rust-lang.org/tools/install)
2. Create symbolic link for Cargo config file (Use privileged terminal):
    ```powershell
    New-Item -ItemType SymbolicLink -Path .\..\common\rust\config.toml -Target  C:\Users\sergi\.cargo\config.toml
    ```
3. Install useful crates:
    ```powershell
    Get-Content -Path ".\common\rust\crates" | ForEach-Object { Invoke-Expression "cargo install $_" }
    ```

## Git
1. [Install Git](https://git-scm.com/download/win)
2. Create symbolic link for Git config file (Use privileged terminal):
    ```powershell
    New-Item -ItemType SymbolicLink -Path .\..\common\gitconfig -Target  C:\Users\sergi\.gitconfig
    ```

## VsCode
1. Create symbolic link for VsCode config files (Use privileged terminal):
    ```powershell
    New-Item -ItemType SymbolicLink -Path .\vscode\keybindings.json -Target  'C:\Users\sergi\AppData\Roaming\Code - Insiders\User\profiles\372b37e5\keybindings.json'
    New-Item -ItemType SymbolicLink -Path .\vscode\settings.json -Target  'C:\Users\sergi\AppData\Roaming\Code - Insiders\User\profiles\372b37e5\settings.json'
    ```
