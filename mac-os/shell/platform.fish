# ~/.config/fish/conf.d/platform.fish
# Loaded before config.fish, so Homebrew tools are available to the shared config.
# Brew
/opt/homebrew/bin/brew shellenv | source

function upup
    yes | brew update; or return
    brew upgrade --yes; or return
    # Defined by dotfiles-media_server on the media server host.
    if functions -q media_server_update
        media_server_update; or return
    end
    yes | cargo install-update -a -g; or return
    yes | rustup update; or return
    yes | espup update; or return
    yes | pi update; or return
    yes | pi update --extensions; or return
    comp
end
