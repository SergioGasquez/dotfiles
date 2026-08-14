# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish
. ~/.dotfiles/linux/shell/espressif.fish
# Arch Linux
abbr -a upup 'sudo pacman -Syy --noconfirm && sudo pacman -Syu --noconfirm && paru -Syua --noconfirm --devel --sudoloop && paru --clean --noconfirm --sudoloop && cargo install-update -a && rustup update && rustup self update && espup update && pi update && pi update --extensions'
# Editor
set -gx EDITOR "cursor --wait"
set -gx VISUAL "cursor --wait"
abbr -a vs 'cursor .'
abbr -a sandbox 'cursor $HOME/Documents/Espressif/sandbox'
abbr -a dotfiles 'cursor $HOME/.dotfiles'
# ESP-RS
export ESPFLASH_BAUD="921600"
# Starship
starship init fish | source
# Zoxide
zoxide init fish | source
# uv
fish_add_path "$HOME/.local/bin"
