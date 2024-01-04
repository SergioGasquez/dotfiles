# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish
# Arch Linux
alias upup="paru -Syua --noconfirm --devel --sudoloop && paru --clean --noconfirm --sudoloop && cargo install-update -a && rustup update && rustup self update"
# Editor
alias vs="code ."
alias sandbox="code $HOME/Documents/Espressif/sandbox"
alias dotfiles="code $HOME/.dotfiles"
## ESP-RS
export ESPFLASH_BAUD="921600"
export PATH="/home/sergio/.rustup/toolchains/esp/xtensa-esp-elf/esp-13.2.0_20230928/xtensa-esp-elf/bin:$PATH"
export LIBCLANG_PATH="/home/sergio/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-16.0.4-20231113/esp-clang/lib"

# Starship
starship init fish | source
