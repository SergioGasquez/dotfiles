# ~/.config/fish/config.fish
# Platform setup is loaded earlier from ~/.config/fish/conf.d/platform.fish
# Rust and uv tools, before anything below runs them (e.g. zoxide)
fish_add_path "$HOME/.cargo/bin" "$HOME/.local/bin"
# No greeting
set -g fish_greeting
# Common aliases
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
