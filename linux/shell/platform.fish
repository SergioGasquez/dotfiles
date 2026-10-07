# ~/.config/fish/conf.d/platform.fish
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
