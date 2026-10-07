# Modern Unix Tools
abbr -a cat bat
abbr -a cd z
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
abbr -a cdtests 'cd ~/Documents/Espressif/tests'
abbr -a cdper 'cd ~/Documents/Espressif/personal'
abbr -a cdtp 'cd ~/Documents/Espressif/third-parties'
abbr -a cdesphal 'cd ~/Documents/Espressif/esp-rs/esp-hal'
abbr -a cdespflash 'cd ~/Documents/Espressif/esp-rs/espflash'
abbr -a cdespup 'cd ~/Documents/Espressif/esp-rs/espup'
abbr -a cdespgenerate 'cd ~/Documents/Espressif/esp-rs/esp-generate'
abbr -a cdcrimdpeq 'cd ~/Documents/Crimpdeq'
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
abbr -a crr 'cargo run --release'
abbr -a ccl 'cargo clean'
abbr -a ccb 'cargo clean && cargo build'
abbr -a cdoc 'cargo doc --open'
abbr -a cesp 'cargo espflash'
abbr -a cf 'cargo fmt'
# Completions
abbr -a comp 'espup completions fish > ~/.dotfiles/common/shell/espup.fish && espflash completions fish > ~/.dotfiles/common/shell/espflash.fish'
# Python
abbr -a pip 'uv pip'
# Pi
abbr -a piclaude 'pi --no-extensions --extension ~/.pi/agent/npm/node_modules/pi-claude-bridge/src/index.ts --extension ~/.pi/agent/extensions/notify-on-finish.ts --model claude-bridge/claude-opus-5-5 --thinking high'
abbr -a pix 'pi --no-extensions --extension ~/.pi/agent/npm/node_modules/pi-claude-bridge/src/index.ts --extension ~/.pi/agent/extensions/notify-on-finish.ts --model claude-bridge/claude-opus-5-5 --thinking high'
abbr -a picursor 'pi --no-extensions --extension ~/.pi/agent/npm/node_modules/pi-cursor-sdk/dist/index.js --extension ~/.pi/agent/extensions/notify-on-finish.ts --model cursor/gpt-5.6-sol@272k:slow'
