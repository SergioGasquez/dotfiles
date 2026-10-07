# ~/.config/fish/config.fish
# Platform setup is loaded earlier from ~/.config/fish/conf.d/platform.fish
# No greeting
set -g fish_greeting
# Commmon aliases
. ~/.config/fish/aliases.fish

if test -f $HOME/.dotfiles/common/shell/espressif.fish
    . $HOME/.dotfiles/common/shell/espressif.fish
end

# Editor (Arch Linux installs the Zed CLI as zeditor)
set -l zed zed
if command -sq zeditor
    set zed zeditor
end
set -gx EDITOR "$zed --wait"
set -gx VISUAL "$zed --wait"
abbr -a vs "$zed . && exit"
abbr -a sandbox "$zed \$HOME/Documents/Espressif/sandbox && exit"
abbr -a dotfiles "$zed \$HOME/.dotfiles && exit"
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
