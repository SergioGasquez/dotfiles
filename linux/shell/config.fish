# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish
# Arch Linux
abbr -a upup 'sudo pacman -Syy --noconfirm && sudo pacman -Syu --noconfirm && paru -Syua --noconfirm --devel --sudoloop && paru --clean --noconfirm --sudoloop && cargo install-update -a && rustup update && rustup self update && espup update'
# Editor
abbr -a vs 'cursor .'
abbr -a sandbox 'cursor $HOME/Documents/Espressif/sandbox'
abbr -a dotfiles 'cursor $HOME/.dotfiles'
# ESP-RS
export ESPFLASH_BAUD="921600"
export PATH="/home/sergio/.rustup/toolchains/esp/xtensa-esp-elf/esp-14.2.0_20240906/xtensa-esp-elf/bin:$PATH"
export PATH="/home/sergio/.local/bin:$PATH"
export LIBCLANG_PATH="/home/sergio/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-18.1.2_20240912/esp-clang/lib"
# ESP-IDF
abbr -a espidf '. /home/sergio/Documents/Espressif/espressif/esp-idf_v5.2/export.fish'
# Starship
starship init fish | source
# Zoxide
zoxide init fish | source
