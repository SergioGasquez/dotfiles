# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish
# Brew
alias upup="brew update && brew upgrade && cargo install-update -a && rustup update && rustup self update && espup update"
# Editor
alias vs="cursor ."
alias sandbox="cursor ~/Documents/Espressif/sandbox"
alias dotfiles="cursor ~/.dotfiles"
## ESP-RS
export ESPFLASH_BAUD="921600"
export PATH="/Users/sergio/.rustup/toolchains/esp/xtensa-esp-elf/esp-14.2.0_20240906/xtensa-esp-elf/bin:$PATH"
export LIBCLANG_PATH="/Users/sergio/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-19.1.2_20250225/esp-clang/lib"
# Brew
eval (/opt/homebrew/bin/brew shellenv)
# SSH
eval $(ssh-agent -c) >/dev/null
ssh-add $HOME/.ssh/id_ed25519 >/dev/null 2>&1
# Starship
starship init fish | source
# uv
fish_add_path "/Users/sergio/.local/bin"
# Zoxide
zoxide init fish | source
# Rust
fish_add_path "/Users/sergio/.cargo/bin"

