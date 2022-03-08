# ~/.config/fish/config.fish
# Modern Unix Command
alias cat="bat"
alias ls="exa"
alias df="duf"
# yay
alias upup="yay -Syu --noconfirm --noansweredit --devel --sudoloop"

# File Navigation
alias cddoc="cd ~/Documents"
alias cdesp="cd ~/Documents/Espressif"
alias cdesprs="cd ~/Documents/Espressif/trees/esp-rs"

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

# Editor
alias c="code ."

# Rust
alias cb='cargo build'

# Starship
starship init fish | source
