# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish
if test -f $HOME/.dotfiles/linux/shell/espressif.fish
    . $HOME/.dotfiles/linux/shell/espressif.fish
end
# Arch Linux
function upup
    paru -Syu --devel --sudoloop --noconfirm; or return
    paru --clean --sudoloop --noconfirm; or return
    yes | cargo install-update -a; or return
    yes | rustup update; or return
    yes | espup update; or return
    yes | pi update; or return
    yes | pi update --extensions
end
# Editor
set -gx EDITOR "cursor --wait"
set -gx VISUAL "cursor --wait"
abbr -a vs 'cursor .'
abbr -a sandbox 'cursor $HOME/Documents/Espressif/sandbox'
abbr -a dotfiles 'cursor $HOME/.dotfiles && exit'
# ESP-RS
export ESPFLASH_BAUD="921600"
# Starship
starship init fish | source
# Zoxide
zoxide init fish | source
# uv
fish_add_path "$HOME/.local/bin"
# Rust
fish_add_path "$HOME/.cargo/bin"
true
