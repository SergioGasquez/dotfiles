# Modern Unix Command
alias cat="bat"
alias ls="eza"
alias df="duf"
alias lsusb="cyme"
# File Navigation
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cddoc="cd ~/Documents"
alias cdesp="cd ~/Documents/Espressif"
alias cdesprs="cd ~/Documents/Espressif/esp-rs"
alias cdespidf="cd ~/Documents/Espressif/espressif"
alias cdforks="cd ~/Documents/Espressif/forks"
alias cdtests="cd ~/Documents/Espressif/tests"
alias cdper="cd ~/Documents/Espressif/personal"
alias cdtp="cd ~/Documents/Espressif/third-parties"
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
alias greum='git rebase upstream/main'
alias gsw='git switch'
alias gswb='git switch -c'
# GitHub CLI
alias ghr='gh repo view --web'
alias ghpr='gh pr --web'
alias ghcpr='gh pr create --web'
# Rust
alias c='cargo'
alias cb='cargo build'
alias ccl='cargo clean'
alias ccb='cargo clean && cargo build'
alias cdoc='cargo doc --open'
alias cesp='cargo espflash'
alias cf='cargo fmt'
# Docker
alias dp='docker system prune -a -f && docker system prune --volumes -a -f'
# Completions
alias comp 'espup completions fish > ~/.dotfiles/common/shell/espup.fish && espflash completions fish > ~/.dotfiles/common/shell/espflash.fish'
