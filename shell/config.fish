# ~/.config/fish/config.fish
# Modern Unix Command
alias cat="bat"
alias ls="exa"
alias df="duf"
# yay
alias upup="yay -Syu --noconfirm --noansweredit --devel --sudoloop"
alias upcode="yay -S --noconfirm visual-studio-code-bin"
alias ya='yay -S --noconfirm --nodiffmenu'
# File Navigation
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cddoc="cd ~/Documents"
alias cdesp="cd ~/Documents/Espressif"
alias cdesprs="cd ~/Documents/Espressif/esp-rs"
alias cdespidf="cd ~/Documents/Espressif/esp-idf"
alias cdforks="cd ~/Documents/Espressif/forks"
alias cdtests="cd ~/Documents/Espressif/tests"

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
# Rust
alias cb='cargo build'
alias ccl='cargo clean'
alias cesp='cargo espflash'
alias cf='cargo fmt'
alias cdoc='cargo doc --open'
alias c='cargo'
# Docker
alias ds='systemctl start docker'
alias dp='docker system prune -a -f && docker system prune --volumes -a -f'
# Esp
alias cg='cargo generate --git https://github.com/esp-rs/esp-idf-template cargo'
alias cei='cargo espflash save-image --release'
alias cef='cargo espflash --release --monitor'
function idf44
    # export IDF_TOOLS_PATH=~/.espressif
    # export IDF_PATH=~/.espressif/frameworks/esp-idf-release-v4.4
    # export IDF_PYTHON_ENV_PATH=~/.espressif/python_env/idf4.4_py3.9_env
    # export IDF_TOOLS_EXPORT_CMD=$IDF_PATH/export.sh
    # export IDF_TOOLS_INSTALL_CMD=$IDF_PATH/install.sh
    # export LIBCLANG_PATH="/home/sergio/.espressif/tools/xtensa-esp32-elf-clang/esp-14.0.0-20220415-x86_64-unknown-linux-gnu/lib/"
    # set PATH $PATH "/home/sergio/.espressif/tools/xtensa-esp32-elf/esp-2021r2-patch3-8.4.0/xtensa-esp32-elf/bin/"
    # set PATH $PATH "/home/sergio/.espressif/tools/xtensa-esp32s2-elf/esp-2021r2-patch3-8.4.0/xtensa-esp32s2-elf/bin/"
    # set PATH $PATH "/home/sergio/.espressif/tools/xtensa-esp32s3-elf/esp-2021r2-patch3-8.4.0/xtensa-esp32s3-elf/bin/"
    # set PATH $PATH "/home/sergio/.espressif/tools/riscv32-esp-elf/esp-2021r2-patch3-8.4.0/riscv32-esp-elf/bin/"
    # set PATH $PATH "$IDF_PATH/components/esptool_py/esptool"
    # set PATH $PATH "$IDF_PATH/components/espcoredump"
    # set PATH $PATH "$IDF_PATH/components/partition_table"
    # set PATH $PATH "$IDF_PATH/components/app_update"
    export IDF_PATH=/home/sergio/.espressif/frameworks/esp-idf-release-v4.4/
    export LIBCLANG_PATH="/home/sergio/.espressif/tools/xtensa-esp32-elf-clang/esp-14.0.0-20220415-x86_64-unknown-linux-gnu/lib/"
    . /home/sergio/.espressif/frameworks/esp-idf-release-v4.4/export.fish
end
# Starship
starship init fish | source
