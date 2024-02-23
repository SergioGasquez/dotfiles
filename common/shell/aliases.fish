# Modern Unix Command
abbr -a cat bat
abbr -a ls eza
abbr -a df duf
abbr -a lsusb cyme
# File Navigation
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a ..... 'cd ../../../..'
abbr -a cddoc 'cd ~/Documents'
abbr -a cdesp 'cd ~/Documents/Espressif'
abbr -a cdesprs 'cd ~/Documents/Espressif/esp-rs'
abbr -a cdespidf 'cd ~/Documents/Espressif/espressif'
abbr -a cdforks 'cd ~/Documents/Espressif/forks'
abbr -a cdtests 'cd ~/Documents/Espressif/tests'
abbr -a cdper 'cd ~/Documents/Espressif/personal'
abbr -a cdtp 'cd ~/Documents/Espressif/third-parties'
abbr -a esp32 'cd ~/Documents/Espressif/tests/esp32'
abbr -a esp32c2 'cd ~/Documents/Espressif/tests/templates/esp32c2'
abbr -a esp32c3 'cd ~/Documents/Espressif/tests/templates/esp32c3'
abbr -a esp32c6 'cd ~/Documents/Espressif/tests/templates/esp32c6'
abbr -a esp32h2 'cd ~/Documents/Espressif/tests/templates/esp32h2'
abbr -a esp32s2 'cd ~/Documents/Espressif/tests/templates/esp32s2'
abbr -a esp32s3 'cd ~/Documents/Espressif/tests/templates/esp32s3'
# Git
abbr -a ga 'git add'
abbr -a gaa 'git add -A'
abbr -a gb 'git branch'
abbr -a gca 'git commit -a -m'
abbr -a gcm 'git commit -m'
abbr -a gc 'git clone --recurse-submodules'
abbr -a go 'git checkout'
abbr -a gob 'git checkout -b'
abbr -a god 'git checkout develop'
abbr -a gs 'git status'
abbr -a gp 'git push'
abbr -a gm 'git merge'
abbr -a gf 'git fetch'
abbr -a gru 'git remote update origin --prune'
abbr -a gst 'git stash'
abbr -a gstp 'git stash pop'
abbr -a gsta 'git stash apply'
abbr -a gstc 'git stash clear'
abbr -a gl 'git pull'
abbr -a gsu 'git submodule update --init --recursive'
abbr -a greum 'git rebase upstream/main'
abbr -a gsw 'git switch'
abbr -a gswb 'git switch -c'
# GitHub CLI
abbr -a ghr 'gh repo view --web'
abbr -a ghpr 'gh pr --web'
abbr -a ghcpr 'gh pr create --web'
# Rust
abbr -a c cargo
abbr -a cb 'cargo build'
abbr -a cbr 'cargo build --release'
abbr -a ccl 'cargo clean'
abbr -a ccb 'cargo clean && cargo build'
abbr -a cdoc 'cargo doc --open'
abbr -a cesp 'cargo espflash'
abbr -a cf 'cargo fmt'
# Docker
abbr -a dp 'docker system prune -a -f && docker system prune --volumes -a -f'
# Completions
abbr -a comp 'espup completions fish > ~/.dotfiles/common/shell/espup.fish && espflash completions fish > ~/.dotfiles/common/shell/espflash.fish'
# Python
abbr -a pip 'uv pip'
