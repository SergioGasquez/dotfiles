# ~/.config/fish/config.fish
# Modern Unix Command
alias cat="bat"
alias ls="exa"
alias df="duf"
# yay
alias upup="yay -Syu --noconfirm --noansweredit --devel --sudoloop"
alias ya='yay -S --noconfirm --nodiffmenu'
# File Navigation
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cddoc="cd ~/Documents"
alias cdesp="cd ~/Documents/Espressif"
alias cdespdev="cd ~/Documents/Espressif/dev"

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
alias dp='docker system prune -a'
# Esp
alias cg='cargo generate --git https://github.com/esp-rs/esp-idf-template cargo'
alias cei='cargo espflash save-image --release'
alias cef='cargo espflash --release --monitor'


# Starship
starship init fish | source
