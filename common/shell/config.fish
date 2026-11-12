# ~/.config/fish/config.fish
# Platform setup is loaded earlier from ~/.config/fish/conf.d/platform.fish
# Rust and uv tools, before anything below runs them (e.g. zoxide)
fish_add_path "$HOME/.cargo/bin" "$HOME/.local/bin"
# No greeting
set -g fish_greeting
# Common aliases
. ~/.config/fish/aliases.fish

# Editor (Arch Linux installs the Zed CLI as zeditor)
set -g zed zed
command -sq zeditor; and set zed zeditor
set -gx EDITOR "$zed --wait"
set -gx VISUAL "$zed --wait"
abbr -a vs "$zed . && exit"
abbr -a sandbox "$zed \$HOME/Documents/Espressif/sandbox && exit"
abbr -a dotfiles "$zed \$HOME/.dotfiles && exit"
# ESP-RS
set -gx ESPFLASH_BAUD 921600
# Starship
starship init fish | source
# Zoxide
zoxide init fish | source
# Herdr Core replaces a kept terminal's program lost to a reboot with a shell
# in its last folder; reopen the Pi session that was open there
# (common/pi/extensions/herdr-resume.ts). Only that shell's parent is Herdr Core.
# It runs from the first prompt, so Pi is a normal foreground job.
if status is-interactive; and set -q HC_TERMINAL_ID
    # Herdr Core supports OSC 7501, but a Pi started before Herdr can answer
    # Pi's one-time support query (e.g. resumed at boot) never reports status
    # and stays out of the agents panel; skip the query.
    set -gx PI_PROGRAM_STATUS 1
    set -l pi_session ~/.pi/agent/herdr-terminals/$HC_TERMINAL_ID
    if test -f $pi_session; and string match -q '*herdr-core' (ps -o comm= -p (string trim (ps -o ppid= -p $fish_pid)))
        function __resume_pi_session --on-event fish_prompt --inherit-variable pi_session
            functions -e __resume_pi_session
            commandline "pi --session "(string escape -- (cat $pi_session))
            commandline -f execute
        end
    end
end
