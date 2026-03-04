# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish

if test -f $HOME/.dotfiles/mac-os/shell/espressif.fish
    . $HOME/.dotfiles/mac-os/shell/espressif.fish
end

# Brew
alias upup="brew update && brew upgrade && cargo install-update -a && rustup update && rustup self update && espup update"
# Editor
set -gx EDITOR "zed --wait"
set -gx VISUAL "zed --wait"
alias vs="zed ."
alias sandbox="zed ~/Documents/Espressif/sandbox"
alias dotfiles="zed ~/.dotfiles"
## ESP-RS
export ESPFLASH_BAUD="921600"
export PATH="$HOME/.rustup/toolchains/esp/xtensa-esp-elf/esp-15.2.0_20250920/xtensa-esp-elf/bin:$PATH"
export LIBCLANG_PATH="$HOME/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-20.1.1_20250829/esp-clang/lib"
# Brew
eval (/opt/homebrew/bin/brew shellenv)
# SSH
if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c) >/dev/null
end
ssh-add $HOME/.ssh/id_ed25519 >/dev/null 2>&1
# Starship
starship init fish | source
# uv
fish_add_path "$HOME/.local/bin"
# Zoxide
zoxide init fish | source
# Rust
fish_add_path "$HOME/.cargo/bin"

