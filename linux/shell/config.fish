# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish
. ~/.dotfiles/linux/shell/espressif.fish
# Arch Linux
function upup
    paru -Syu --devel --sudoloop; or return
    paru --clean --sudoloop; or return
    cargo install-update -a; or return
    rustup update; or return
    espup update; or return
    pi update; or return
    pi update --extensions
end
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
