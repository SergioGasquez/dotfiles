# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish
# Arch Linux
alias upup="paru -Syua --noconfirm --devel --sudoloop && paru --clean && cargo install-update -a && rustup update && rustup self update"
# Editor
alias vs="code ."
alias sandbox="code $HOME/Documents/Espressif/sandbox"
alias dotfiles="code $HOME/Documents/dotfiles"
## ESP-RS
export ESPFLASH_BAUD="921600"
export LIBCLANG_PATH="$HOME/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-16.0.0-20230516/esp-clang/lib"
export PATH="$HOME/.rustup/toolchains/esp/xtensa-esp-elf/esp-13.2.0_20230928/xtensa-esp-elf/bin:$PATH"
export PATH="$HOME/.rustup/toolchains/esp/riscv32-esp-elf/esp-13.2.0_20230928/riscv32-esp-elf/bin:$PATH"

# Starship
starship init fish | source
