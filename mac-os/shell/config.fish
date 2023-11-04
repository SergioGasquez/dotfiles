# ~/.config/fish/config.fish
# Commmon aliases
. ~/.config/fish/aliases.fish
# Brew
alias upup="brew upgrade && cargo install-update -a && rustup update && rustup self update"
# Editor
alias vs="code-insiders ."
alias code="code-insiders"
alias sandbox="code-insiders ~/Documents/Espressif/sandbox"
## ESP-RS
export ESPFLASH_BAUD="921600"
export LIBCLANG_PATH="$HOME/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-16.0.0-20230516/esp-clang/lib"
export PATH="$HOME/.rustup/toolchains/esp/xtensa-esp-elf/esp-13.2.0_20230928/xtensa-esp-elf/bin:$PATH"
export PATH="$HOME/.rustup/toolchains/esp/riscv32-esp-elf/esp-13.2.0_20230928/riscv32-esp-elf/bin:$PATH"
## ESP-IDF
function release-v4.4
    export IDF_PATH=$HOME/.espressif/frameworks/release-v4.4/esp-idf/
    . $HOME/.espressif/frameworks/release-v4.4/esp-idf/export.fish
end
function master
    export IDF_PATH=$HOME/.espressif/frameworks/master/esp-idf/
    . $HOME/.espressif/frameworks/master/esp-idf/export.fish
end
function v5.0-dev
    export IDF_PATH=$HOME/.espressif/frameworks/v5.0-dev/esp-idf/
    . $HOME/.espressif/frameworks/v5.0-dev/esp-idf/export.fish
end
function v5.1-dev
    export IDF_PATH=$HOME/.espressif/frameworks/v5.1-dev/esp-idf/
    . $HOME/.espressif/frameworks/v5.1-dev/esp-idf/export.fish
end

# Brew
eval (/opt/homebrew/bin/brew shellenv)

# Starship
starship init fish | source
