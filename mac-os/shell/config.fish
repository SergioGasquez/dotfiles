# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish

if test -f $HOME/.dotfiles/mac-os/shell/espressif.fish
    . $HOME/.dotfiles/mac-os/shell/espressif.fish
end

# Brew
alias upup="brew update && brew upgrade && cargo install-update -a && rustup update && rustup self update && espup update && pi update && pi update --extensions"
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
