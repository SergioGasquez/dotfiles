# ~/.config/fish/conf.d/platform.fish
# Loaded before config.fish, so Homebrew tools are available to the shared config.
# Brew
eval (/opt/homebrew/bin/brew shellenv)

function upup
    yes | brew update; or return
    brew upgrade --yes; or return
    yes | cargo install-update -a; or return
    yes | rustup update; or return
    yes | espup update; or return
    yes | pi update; or return
    yes | pi update --extensions
end
