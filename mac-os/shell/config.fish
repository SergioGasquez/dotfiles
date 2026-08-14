# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish

if test -f $HOME/.dotfiles/mac-os/shell/espressif.fish
    . $HOME/.dotfiles/mac-os/shell/espressif.fish
end

# Brew
function upup
    yes | brew update; or return
    brew upgrade --yes; or return
    yes | cargo install-update -a; or return
    yes | rustup update; or return
    yes | espup update; or return
    yes | pi update; or return
    yes | pi update --extensions
end
# Editor
set -gx EDITOR "cursor --wait"
set -gx VISUAL "cursor --wait"
alias vs="cursor ."
alias sandbox="cursor ~/Documents/Espressif/sandbox"
alias dotfiles="cursor ~/.dotfiles"
## ESP-RS
export ESPFLASH_BAUD="921600"
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
