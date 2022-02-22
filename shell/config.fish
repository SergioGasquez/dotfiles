# ~/.config/fish/config.fish

alias cat="bat"
alias ls="exa"
alias df="duf"
# yay
alias upup="yay -Syu --noconfirm --noansweredit --devel --sudoloop"

# File management
alias cddoc="cd ~/Documents"

# Editor
alias c="code ."

# Starship
starship init fish | source
