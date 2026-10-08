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
abbr -a cdcrimpdeq 'cd ~/Documents/Crimpdeq'
# Git
abbr -a ga 'git add'
abbr -a gaa 'git add -A'
abbr -a gb 'git branch'
abbr -a gca 'git commit -a -m'
abbr -a gcm 'git commit -m'
abbr -a gc 'git clone --recurse-submodules'
abbr -a go 'git checkout'
abbr -a gob 'git checkout -b'
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
abbr -a ghpr 'gh pr view --web'
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
function comp
    for tool in espup espflash
        set -l out ($tool completions fish | string collect); or return
        printf '%s\n' $out > ~/.dotfiles/common/shell/$tool.fish
    end
    # Make --chip complete chip names
    set -l out (probe-rs complete install --manual | string replace -r -- ' -l chip -r$' ' -l chip -x -a "(probe-rs complete chip-list \'\')"' | string collect); or return
    printf '%s\n' $out > ~/.dotfiles/common/shell/probe-rs.fish
end
# Python
abbr -a pip 'uv pip'
# Pi
abbr -a piclaude 'pi --no-extensions --extension ~/.pi/agent/npm/node_modules/pi-claude-bridge/src/index.ts --extension ~/.pi/agent/extensions/notify-on-finish.ts --model claude-bridge/claude-opus-5-5 --thinking high'
set -g pix_cmd pi --no-extensions --extension ~/.pi/agent/npm/node_modules/pi-claude-bridge/src/index.ts --extension ~/.pi/agent/extensions/notify-on-finish.ts --model claude-bridge/claude-opus-5-5 --thinking high
# `pix` + enter expands to $pix_cmd; `pix <project>` and `pixi` call the pix function (pix.fish)
function _pix_abbr
    # Space is inserted before expansion runs: keep `pix ` unexpanded so it can take a project
    string match -q -- '* ' (commandline); and return 1
    string escape -- $pix_cmd | string join ' '
end
abbr -a pix --position command --function _pix_abbr
abbr -a pixi 'pix -ide'
# Consume the `pix -ide` marker: type and run pix once the terminal shows its first prompt
if set -q ZED_TERM; and status is-interactive; and test "$(cat /tmp/pix-autostart 2>/dev/null)" = "$PWD"
    rm /tmp/pix-autostart
    function _pix_autostart --on-event fish_prompt
        functions -e _pix_autostart
        commandline -r pix
        commandline -f execute
    end
end
abbr -a picursor 'pi --no-extensions --extension ~/.pi/agent/npm/node_modules/pi-cursor-sdk/dist/index.js --extension ~/.pi/agent/extensions/notify-on-finish.ts --model cursor/gpt-5.6-sol@272k:slow'
