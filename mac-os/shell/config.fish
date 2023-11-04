# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish
# Brew
alias upup="brew upgrade && cargo install-update -a && rustup update && rustup self update"
# Editor
alias vs="code-insiders ."
alias code="code-insiders"
alias sandbox="code-insiders ~/Documents/Espressif/sandbox"
alias dotfiles="code-insiders ~/Documents/dotfiles"

## ESP-RS
export ESPFLASH_BAUD="921600"
export LIBCLANG_PATH="$HOME/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-16.0.0-20230516/esp-clang/lib"
export PATH="$HOME/.rustup/toolchains/esp/xtensa-esp-elf/esp-13.2.0_20230928/xtensa-esp-elf/bin:$PATH"
export PATH="$HOME/.rustup/toolchains/esp/riscv32-esp-elf/esp-13.2.0_20230928/riscv32-esp-elf/bin:$PATH"

# Brew
eval (/opt/homebrew/bin/brew shellenv)

# Starship
starship init fish | source
