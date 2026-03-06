# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish
# Arch Linux
abbr -a upup 'sudo pacman -Syy --noconfirm && sudo pacman -Syu --noconfirm && paru -Syua --noconfirm --devel --sudoloop && paru --clean --noconfirm --sudoloop && cargo install-update -a && rustup update && rustup self update && espup update'
# Editor
set -gx EDITOR "zed --wait"
set -gx VISUAL "zed --wait"
abbr -a vs 'zed .'
abbr -a sandbox 'zed $HOME/Documents/Espressif/sandbox'
abbr -a dotfiles 'zed $HOME/.dotfiles'
# ESP-RS
export ESPFLASH_BAUD="921600"
# Starship
starship init fish | source
# Zoxide
zoxide init fish | source
# uv
fish_add_path "$HOME/.local/bin"
