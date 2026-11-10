# `pix [project [pi args...]]` runs pi (default model from settings.json) inside that project
# `pix -ide [project]` (or `pixi [project]`) opens the project in Zed and runs pix in its first terminal
function pix --description 'Run pi in a project directory'
    argparse -s ide -- $argv; or return
    if set -q argv[1]
        set -l dir (path filter -d ~/Documents/Espressif/esp-rs/$argv[1] ~/Documents/Crimpdeq/$argv[1])
        if not set -q dir[1]
            echo "pix: unknown project '$argv[1]'" >&2
            return 1
        end
        cd $dir[1]; or return
    end
    if not set -q _flag_ide
        pi $argv[2..]
        return
    end
    if set -q argv[2]
        echo 'pix: -ide takes only a project' >&2
        return 1
    end
    set -l zed zed
    command -q zeditor; and set zed zeditor
    echo $PWD >/tmp/pix-autostart
    $zed .
end
