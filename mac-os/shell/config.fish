# ~/.config/fish/config.fish
# Modern Unix Command
alias cat="bat"
alias ls="exa"
alias df="duf"
# File Navigation
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cddoc="cd ~/Documents"
alias cdesp="cd ~/Documents/Espressif"
alias cdesprs="cd ~/Documents/Espressif/esp-rs"
alias cdforks="cd ~/Documents/Espressif/forks"
alias cdtests="cd ~/Documents/Espressif/tests"
alias cdpersonal="cd ~/Documents/Espressif/personal"
# Git
alias ga='git add'
alias gaa='git add -A'
alias gb='git branch'
alias gca='git commit -a -m'
alias gcm='git commit -m'
alias gc='git clone --recurse-submodules'
alias go='git checkout'
alias gob='git checkout -b'
alias god='git checkout develop'
alias gs='git status'
alias gp='git push'
alias gm='git merge'
alias gf='git fetch'
alias gru='git remote update origin --prune'
alias gst='git stash'
alias gstp='git stash pop'
alias gsta='git stash apply'
alias gstc='git stash clear'
alias gl='git pull'
alias gsu='git submodule update --init --recursive'
alias gr='git rebase -i'
alias gre='git rebase --edit-todo'
alias grc='git rebase --continue'
alias gsw='git switch'
alias gswb='git switch -c'
# Editor
alias vs="code ."
alias sandbox="code ~/Documents/Espressif/sandbox"
# Rust
alias cb='cargo build'
alias ccl='cargo clean'
alias cesp='cargo espflash'
alias cf='cargo fmt'
alias cdoc='cargo doc --open'
alias c='cargo'
# Docker
alias ds='systemctl start docker'
alias dp='docker system prune -a'
# Esp
alias cg='cargo generate --git https://github.com/esp-rs/esp-idf-template cargo'
alias cei='cargo espflash save-image --release'
alias cef='cargo espflash flash --release --monitor'
## ESP-RS
export LIBCLANG_PATH="/Users/sergio/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-16.0.0-20230516/esp-clang/lib"
export PATH="/Users/sergio/.rustup/toolchains/esp/xtensa-esp32-elf/esp-12.2.0_20230208/xtensa-esp32-elf/bin:$PATH"
export PATH="/Users/sergio/.rustup/toolchains/esp/xtensa-esp32s2-elf/esp-12.2.0_20230208/xtensa-esp32s2-elf/bin:$PATH"
export PATH="/Users/sergio/.rustup/toolchains/esp/xtensa-esp32s3-elf/esp-12.2.0_20230208/xtensa-esp32s3-elf/bin:$PATH"
export PATH="/Users/sergio/.rustup/toolchains/esp/riscv32-esp-elf/esp-12.2.0_20230208/riscv32-esp-elf/bin:$PATH"
export ESPFLASH_BAUD="921600"
## ESP-IDF
function release-v4.4
    export IDF_PATH=/Users/sergio/.espressif/frameworks/release-v4.4/esp-idf/
    . /Users/sergio/.espressif/frameworks/release-v4.4/esp-idf/export.fish
end
function master
    export IDF_PATH=/Users/sergio/.espressif/frameworks/master/esp-idf/
    . /Users/sergio/.espressif/frameworks/master/esp-idf/export.fish
end
function v5.0-dev
    export IDF_PATH=/Users/sergio/.espressif/frameworks/v5.0-dev/esp-idf/
    . /Users/sergio/.espressif/frameworks/v5.0-dev/esp-idf/export.fish
end
function v5.1-dev
    export IDF_PATH=/Users/sergio/.espressif/frameworks/v5.1-dev/esp-idf/
    . /Users/sergio/.espressif/frameworks/v5.1-dev/esp-idf/export.fish
end

# Brew
eval (/opt/homebrew/bin/brew shellenv)

# Starship
starship init fish | source