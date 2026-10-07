# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_probe_rs_global_optspecs
    string join \n log-file= log-to-folder r/report= host= token= preset= h/help V/version
end

function __fish_probe_rs_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_probe_rs_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_probe_rs_using_subcommand
    set -l cmd (__fish_probe_rs_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c probe-rs -n "__fish_probe_rs_needs_command" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_needs_command" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_needs_command" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_needs_command" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_needs_command" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_needs_command" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -s V -l version -d 'Print version'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "dap-server" -d 'Debug Adapter Protocol (DAP) server. See <https://probe.rs/docs/tools/debugger/>'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "list" -d 'List all connected debug probes'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "info" -d 'Gets info about the selected debug probe and connected target'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "reset" -d 'Resets the target attached to the selected debug probe'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "gdb" -d 'Run a GDB server'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "debug" -d 'Basic command line debugger'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "download" -d 'Download memory to attached target'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "verify" -d 'Compare memory to attached target'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "erase" -d 'Erase all nonvolatile memory of attached target'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "run" -d 'Flash and run an ELF program'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "attach" -d 'Attach to rtt logging'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "trace" -d 'Trace a memory location on the target'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "itm" -d 'Configure and monitor ITM trace packets from the target'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "chip" -d 'Inspect internal registry of supported chips'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "benchmark" -d 'Measure the throughput of the selected debug probe'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "profile" -d 'Profile on-target runtime performance of target ELF program'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "serve" -d 'Start a server that accepts remote connections'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "read" -d 'Read from target memory address'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "write" -d 'Write to target memory address'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "complete" -d 'Install and complete autocomplete scripts'
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "mi"
complete -c probe-rs -n "__fish_probe_rs_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand dap-server" -l port -d 'IP port number to listen for incoming DAP connections, e.g. "50000". When omitted, the DAP server communicates over stdin/stdout' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand dap-server" -l ip -d 'IP address to listen for incoming DAP connections, e.g. "127.0.0.1". Defaults to "127.0.0.1"' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand dap-server" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand dap-server" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand dap-server" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand dap-server" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand dap-server" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand dap-server" -l single-session -d 'Some editors and IDEs expect the debug adapter processes to exit at the end of every debug session (on receiving a `Disconnect` or `Terminate` request)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand dap-server" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand dap-server" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand list" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand list" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand list" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand list" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand list" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand list" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand list" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l target-sel -d 'SWD Multidrop target selection value for --verbose mode' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l scan-chain -d 'Override JTAG scan chain IR lengths for --verbose mode (bypasses auto-detection)' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -s v -l verbose -d 'Enumerate all debug ports and components on the target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand info" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l core -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand reset" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l gdb-connection-string -d 'Use this flag to override the default GDB connection string (localhost:1337).' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l gdb -d 'Spawn gdb after starting the gdbserver.' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l reset-halt -d 'Use this flag to reset and halt (instead of just a halt) the attached core after attaching to the target.'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand gdb" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l core -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -s c -l command -d 'Execute a debug console command before entering the interactive console. May be specified multiple times; the commands are executed in order' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l flash-layout -d 'Requests the flash builder to output the layout into the given file in SVG format' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l prefer-flash-algorithm -d 'The preferred flash algorithms for specific memory regions can be overridden' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l ram-chunk-size -d 'Chunk size, in bytes, for writing data directly to RAM' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l launch -d 'Launch instead of just attaching. This will reset the target and allow the binary to be flashed, if provided'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l no-catch-reset -d 'Disable reset vector catch if its supported on the target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l no-catch-hardfault -d 'Disable hardfault vector catch if its supported on the target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l no-catch-svc -d 'Disable SVC vector catch (halts on SVC exception). Only applies to ARMv7-A/R cores'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l no-catch-hlt -d 'Disable HLT vector catch (halts on UNDEF exception for HLT instruction). Only applies to ARMv7-A/R cores'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l no-rtt -d 'Disable reading RTT data'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l disable-progressbars
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l disable-double-buffering -d 'Use this flag to disable double-buffering when downloading flash data. If download fails during programming with timeout errors, try this option'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l restore-unwritten -d 'Enable this flag to restore all bytes erased in the sector erase but not overwritten by any page'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l preverify -d 'Before flashing, read back all the flashed data to skip flashing if the device is up to date'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l verify -d 'After flashing, read back all the flashed data to verify it has been written correctly'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l chip-erase -d 'Whether to erase the entire chip before downloading'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l read-flasher-rtt -d 'Whether to read the RTT output from the flash loader, if available'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand debug" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l flash-layout -d 'Requests the flash builder to output the layout into the given file in SVG format' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l prefer-flash-algorithm -d 'The preferred flash algorithms for specific memory regions can be overridden' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l ram-chunk-size -d 'Chunk size, in bytes, for writing data directly to RAM' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l binary-format -r -f -a "target\t''
bin\t''
hex\t''
elf\t''
idf\t''
uf2\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l base-address -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l skip -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l idf-bootloader -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l idf-partition-table -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l idf-target-app-partition -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l idf-flash-mode -r -f -a "qio\t''
qout\t''
dio\t''
dout\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l idf-flash-freq -r -f -a "12mhz\t''
15mhz\t''
16mhz\t''
20mhz\t''
24mhz\t''
26mhz\t''
30mhz\t''
40mhz\t''
48mhz\t''
60mhz\t''
80mhz\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l skip-section -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l disable-progressbars
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l disable-double-buffering -d 'Use this flag to disable double-buffering when downloading flash data. If download fails during programming with timeout errors, try this option'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l restore-unwritten -d 'Enable this flag to restore all bytes erased in the sector erase but not overwritten by any page'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l preverify -d 'Before flashing, read back all the flashed data to skip flashing if the device is up to date'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l verify -d 'After flashing, read back all the flashed data to verify it has been written correctly'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l chip-erase -d 'Whether to erase the entire chip before downloading'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l read-flasher-rtt -d 'Whether to read the RTT output from the flash loader, if available'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l start -d 'Start the firmware after the download'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand download" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l binary-format -r -f -a "target\t''
bin\t''
hex\t''
elf\t''
idf\t''
uf2\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l base-address -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l skip -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l idf-bootloader -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l idf-partition-table -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l idf-target-app-partition -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l idf-flash-mode -r -f -a "qio\t''
qout\t''
dio\t''
dout\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l idf-flash-freq -r -f -a "12mhz\t''
15mhz\t''
16mhz\t''
20mhz\t''
24mhz\t''
26mhz\t''
30mhz\t''
40mhz\t''
48mhz\t''
60mhz\t''
80mhz\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l skip-section -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l disable-progressbars
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l read-flasher-rtt -d 'Whether to read the RTT output from the flash loader, if available'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand verify" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l disable-progressbars
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l read-flasher-rtt -d 'Whether to read the RTT output from the flash loader, if available'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand erase" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l format -d 'Configure formatting of the test report output' -r -f -a "pretty\t'One line per test. Output for humans. (default)'
terse\t'One character per test. Usefull for test suites with many tests'
json\t'Json output'"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l skip-test -d 'Skip tests whose names contain FILTER (this flag can be used multiple times)' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -s Z -d 'No-op, ignored. Flag only exists for CLI compatibility with libtest' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l flash-layout -d 'Requests the flash builder to output the layout into the given file in SVG format' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l prefer-flash-algorithm -d 'The preferred flash algorithms for specific memory regions can be overridden' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l ram-chunk-size -d 'Chunk size, in bytes, for writing data directly to RAM' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l binary-format -r -f -a "target\t''
bin\t''
hex\t''
elf\t''
idf\t''
uf2\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l base-address -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l skip -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l idf-bootloader -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l idf-partition-table -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l idf-target-app-partition -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l idf-flash-mode -r -f -a "qio\t''
qout\t''
dio\t''
dout\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l idf-flash-freq -r -f -a "12mhz\t''
15mhz\t''
16mhz\t''
20mhz\t''
24mhz\t''
26mhz\t''
30mhz\t''
40mhz\t''
48mhz\t''
60mhz\t''
80mhz\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l skip-section -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l log-format -d 'The format string to use when printing defmt encoded log messages from the target' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l target-output-file -d 'File name to store formatted output at. Different channels can be assigned to different files using channel=file arguments to multiple occurrences (eg. `--target-output-file defmt=out/defmt.txt --target-output-file out/default`). Channel names can be prefixed with `rtt:` or `semihosting:` (eg. `semihosting:stdout`) to disambiguate' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l scan-region -d 'Memory region to scan for control block' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l rtt-channel-mode -d 'RTT channel mode to use' -r -f -a "no-block-skip\t'Skip writing the data completely if it doesn\'t fit in its entirety'
no-block-trim\t'Write as much as possible of the data and ignore the rest'
block-if-full\t'Block (spin) if the buffer is full. Note that if the application writes within a critical section, using this mode can cause the application to freeze if the buffer becomes full and is not read by the host'"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l rtt-up-channels -d 'RTT up channels to display' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l rtt-down-channel -d 'RTT down channel to use' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l stack-frame-limit -d 'Limit the number of stack frames to print' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l semihosting-file -d 'File name to expose via semihosting. Values ending with a slash expose the whole directory. By using `target=host` arguments the names can differ between the host and the target. TCP and UNIX domain socket connections are possible by exposing files of the form `tcp:hostname:port` or `unix:/some/path`. `file:/some/path` is valid for files too. If the target path starts with a `^` and ends with a `$` it\'s interpreted as a regular expression and captures are expanded in the host path (e.g. `--semihosting-file "^/(\\d).(\\d)$=/path$1/file$2.txt"`)' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l catch-reset -d 'Deprecated(catch_reset is enabled by default) - Use no_reset_catch to disable this'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l catch-hardfault -d 'Deprecated(catch_hardfault is enabled by default) - Use no_catch_hardfault to disable this'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l no-catch-reset -d 'Disable reset vector catch if its supported on the target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l no-catch-hardfault -d 'Disable hardfault vector catch if its supported on the target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l no-catch-svc -d 'Disable SVC vector catch (halts on SVC exception). Only applies to ARMv7-A/R cores'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l no-catch-hlt -d 'Disable HLT vector catch (halts on UNDEF exception for HLT instruction). Only applies to ARMv7-A/R cores'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l list -d 'List all tests instead of executing them'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l exact -d 'If set, filters are matched exactly rather than by substring'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l ignored -d 'If set, run only ignored tests'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l include-ignored -d 'If set, run ignored and non-ignored tests'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l nocapture
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l show-output -d 'No-op, ignored. libtest-mimic does not currently capture stdout'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l disable-progressbars
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l disable-double-buffering -d 'Use this flag to disable double-buffering when downloading flash data. If download fails during programming with timeout errors, try this option'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l restore-unwritten -d 'Enable this flag to restore all bytes erased in the sector erase but not overwritten by any page'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l preverify -d 'Before flashing, read back all the flashed data to skip flashing if the device is up to date'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l verify -d 'After flashing, read back all the flashed data to verify it has been written correctly'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l chip-erase -d 'Whether to erase the entire chip before downloading'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l read-flasher-rtt -d 'Whether to read the RTT output from the flash loader, if available'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l list-rtt -d 'List RTT channels and exit'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l always-print-stacktrace -d 'Always print the stacktrace on ctrl + c'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l no-location -d 'Suppress filename and line number information'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l no-timestamps -d 'Suppress timestamps'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand run" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l binary-format -r -f -a "target\t''
bin\t''
hex\t''
elf\t''
idf\t''
uf2\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l base-address -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l skip -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l idf-bootloader -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l idf-partition-table -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l idf-target-app-partition -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l idf-flash-mode -r -f -a "qio\t''
qout\t''
dio\t''
dout\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l idf-flash-freq -r -f -a "12mhz\t''
15mhz\t''
16mhz\t''
20mhz\t''
24mhz\t''
26mhz\t''
30mhz\t''
40mhz\t''
48mhz\t''
60mhz\t''
80mhz\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l skip-section -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l log-format -d 'The format string to use when printing defmt encoded log messages from the target' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l target-output-file -d 'File name to store formatted output at. Different channels can be assigned to different files using channel=file arguments to multiple occurrences (eg. `--target-output-file defmt=out/defmt.txt --target-output-file out/default`). Channel names can be prefixed with `rtt:` or `semihosting:` (eg. `semihosting:stdout`) to disambiguate' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l scan-region -d 'Memory region to scan for control block' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l rtt-channel-mode -d 'RTT channel mode to use' -r -f -a "no-block-skip\t'Skip writing the data completely if it doesn\'t fit in its entirety'
no-block-trim\t'Write as much as possible of the data and ignore the rest'
block-if-full\t'Block (spin) if the buffer is full. Note that if the application writes within a critical section, using this mode can cause the application to freeze if the buffer becomes full and is not read by the host'"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l rtt-up-channels -d 'RTT up channels to display' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l rtt-down-channel -d 'RTT down channel to use' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l stack-frame-limit -d 'Limit the number of stack frames to print' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l semihosting-file -d 'File name to expose via semihosting. Values ending with a slash expose the whole directory. By using `target=host` arguments the names can differ between the host and the target. TCP and UNIX domain socket connections are possible by exposing files of the form `tcp:hostname:port` or `unix:/some/path`. `file:/some/path` is valid for files too. If the target path starts with a `^` and ends with a `$` it\'s interpreted as a regular expression and captures are expanded in the host path (e.g. `--semihosting-file "^/(\\d).(\\d)$=/path$1/file$2.txt"`)' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l catch-reset -d 'Deprecated(catch_reset is enabled by default) - Use no_reset_catch to disable this'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l catch-hardfault -d 'Deprecated(catch_hardfault is enabled by default) - Use no_catch_hardfault to disable this'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l no-catch-reset -d 'Disable reset vector catch if its supported on the target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l no-catch-hardfault -d 'Disable hardfault vector catch if its supported on the target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l no-catch-svc -d 'Disable SVC vector catch (halts on SVC exception). Only applies to ARMv7-A/R cores'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l no-catch-hlt -d 'Disable HLT vector catch (halts on UNDEF exception for HLT instruction). Only applies to ARMv7-A/R cores'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l list-rtt -d 'List RTT channels and exit'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l always-print-stacktrace -d 'Always print the stacktrace on ctrl + c'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l no-location -d 'Suppress filename and line number information'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l no-timestamps -d 'Suppress timestamps'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand attach" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l core -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand trace" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l core -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -f -a "memory" -d 'Direct ITM data to Embedded Trace Buffer/FIFO (ETB/ETF) for extraction'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -f -a "swo" -d 'Direct ITM traffic out the TRACESWO pin for reception by the probe'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and not __fish_seen_subcommand_from memory swo help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from memory" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from memory" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from memory" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from memory" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from memory" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from memory" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from memory" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from swo" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from swo" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from swo" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from swo" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from swo" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from swo" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from swo" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from help" -f -a "memory" -d 'Direct ITM data to Embedded Trace Buffer/FIFO (ETB/ETF) for extraction'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from help" -f -a "swo" -d 'Direct ITM traffic out the TRACESWO pin for reception by the probe'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand itm; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and not __fish_seen_subcommand_from list info help" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and not __fish_seen_subcommand_from list info help" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and not __fish_seen_subcommand_from list info help" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and not __fish_seen_subcommand_from list info help" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and not __fish_seen_subcommand_from list info help" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and not __fish_seen_subcommand_from list info help" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and not __fish_seen_subcommand_from list info help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and not __fish_seen_subcommand_from list info help" -f -a "list" -d 'Lists all the available families and their chips with their full'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and not __fish_seen_subcommand_from list info help" -f -a "info" -d 'Shows chip properties of a specific chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and not __fish_seen_subcommand_from list info help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from list" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from list" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from list" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from list" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from list" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from list" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from info" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from info" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from info" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from info" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from info" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from info" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from info" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from help" -f -a "list" -d 'Lists all the available families and their chips with their full'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from help" -f -a "info" -d 'Shows chip properties of a specific chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand chip; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l address -d 'Start address for the benchmark test' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l min-speed -d 'Minimum speed for the debug probe' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l max-speed -d 'Maximum speed for the debug probe' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l word-size -d 'Word size for read/write accesses' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l iterations -d 'Number of times to run each test' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand benchmark" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l format -d 'Configure formatting of the test report output' -r -f -a "pretty\t'One line per test. Output for humans. (default)'
terse\t'One character per test. Usefull for test suites with many tests'
json\t'Json output'"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l skip-test -d 'Skip tests whose names contain FILTER (this flag can be used multiple times)' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -s Z -d 'No-op, ignored. Flag only exists for CLI compatibility with libtest' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l flash-layout -d 'Requests the flash builder to output the layout into the given file in SVG format' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l prefer-flash-algorithm -d 'The preferred flash algorithms for specific memory regions can be overridden' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l ram-chunk-size -d 'Chunk size, in bytes, for writing data directly to RAM' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l binary-format -r -f -a "target\t''
bin\t''
hex\t''
elf\t''
idf\t''
uf2\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l base-address -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l skip -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l idf-bootloader -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l idf-partition-table -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l idf-target-app-partition -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l idf-flash-mode -r -f -a "qio\t''
qout\t''
dio\t''
dout\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l idf-flash-freq -r -f -a "12mhz\t''
15mhz\t''
16mhz\t''
20mhz\t''
24mhz\t''
26mhz\t''
30mhz\t''
40mhz\t''
48mhz\t''
60mhz\t''
80mhz\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l skip-section -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l log-format -d 'The format string to use when printing defmt encoded log messages from the target' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l target-output-file -d 'File name to store formatted output at. Different channels can be assigned to different files using channel=file arguments to multiple occurrences (eg. `--target-output-file defmt=out/defmt.txt --target-output-file out/default`). Channel names can be prefixed with `rtt:` or `semihosting:` (eg. `semihosting:stdout`) to disambiguate' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l scan-region -d 'Memory region to scan for control block' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l rtt-channel-mode -d 'RTT channel mode to use' -r -f -a "no-block-skip\t'Skip writing the data completely if it doesn\'t fit in its entirety'
no-block-trim\t'Write as much as possible of the data and ignore the rest'
block-if-full\t'Block (spin) if the buffer is full. Note that if the application writes within a critical section, using this mode can cause the application to freeze if the buffer becomes full and is not read by the host'"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l rtt-up-channels -d 'RTT up channels to display' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l rtt-down-channel -d 'RTT down channel to use' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l stack-frame-limit -d 'Limit the number of stack frames to print' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l semihosting-file -d 'File name to expose via semihosting. Values ending with a slash expose the whole directory. By using `target=host` arguments the names can differ between the host and the target. TCP and UNIX domain socket connections are possible by exposing files of the form `tcp:hostname:port` or `unix:/some/path`. `file:/some/path` is valid for files too. If the target path starts with a `^` and ends with a `$` it\'s interpreted as a regular expression and captures are expanded in the host path (e.g. `--semihosting-file "^/(\\d).(\\d)$=/path$1/file$2.txt"`)' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l duration -d 'Duration of profile in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l catch-reset -d 'Deprecated(catch_reset is enabled by default) - Use no_reset_catch to disable this'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l catch-hardfault -d 'Deprecated(catch_hardfault is enabled by default) - Use no_catch_hardfault to disable this'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l no-catch-reset -d 'Disable reset vector catch if its supported on the target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l no-catch-hardfault -d 'Disable hardfault vector catch if its supported on the target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l no-catch-svc -d 'Disable SVC vector catch (halts on SVC exception). Only applies to ARMv7-A/R cores'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l no-catch-hlt -d 'Disable HLT vector catch (halts on UNDEF exception for HLT instruction). Only applies to ARMv7-A/R cores'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l list -d 'List all tests instead of executing them'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l exact -d 'If set, filters are matched exactly rather than by substring'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l ignored -d 'If set, run only ignored tests'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l include-ignored -d 'If set, run ignored and non-ignored tests'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l nocapture
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l show-output -d 'No-op, ignored. libtest-mimic does not currently capture stdout'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l disable-progressbars
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l disable-double-buffering -d 'Use this flag to disable double-buffering when downloading flash data. If download fails during programming with timeout errors, try this option'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l restore-unwritten -d 'Enable this flag to restore all bytes erased in the sector erase but not overwritten by any page'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l preverify -d 'Before flashing, read back all the flashed data to skip flashing if the device is up to date'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l verify -d 'After flashing, read back all the flashed data to verify it has been written correctly'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l chip-erase -d 'Whether to erase the entire chip before downloading'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l read-flasher-rtt -d 'Whether to read the RTT output from the flash loader, if available'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l list-rtt -d 'List RTT channels and exit'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l always-print-stacktrace -d 'Always print the stacktrace on ctrl + c'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l no-location -d 'Suppress filename and line number information'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l no-timestamps -d 'Suppress timestamps'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l flash -d 'Flash the ELF before profiling'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l reset -d 'Reset before profiling'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -a "flat" -d 'Faster flat profiling that only records currently executing function'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -a "callstack" -d 'Slower callstack profiling that records the executing function and all callers'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and not __fish_seen_subcommand_from flat callstack help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -l core -d 'Which core to profile' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -l limit -d 'Limit the number of entries to output' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -l line-info -d 'Print file and line info for each entry'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -f -a "naive" -d 'Naive, Halt -> Read PC -> Resume profiler'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -f -a "itm" -d 'Use the Itm port to profile the chip (ARM only)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -f -a "pcsr" -d 'Use the DWT_PCSR to profile the chip (ARM only)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from flat" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -l rate -d 'Target sampling rate, in Hz. Higher frequencies will have a larger impact on execution and so will be less representative of true behaviour. If the rate is set too high it may not be achieved' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -l cores -d 'Comma separated list of cores to profile, numbered from 0. If more than one is specified then the list of cores will be cycled through, with a single core sampled at each interval' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -l output-format -d 'Output format' -r -f -a "firefox-profiler\t'Firefox profiler output format that can be opened using: samply load probe-rs-profile.json.gz'"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -f -a "naive-dwarf" -d 'Naively (halt -> walk -> resume) unwind callstack using DWARF debug information'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -f -a "naive-frame-pointer" -d 'Naively (halt -> walk -> resume) walk callstack using frame pointers and frame record chain. You should ensure the program was compiled with frame pointers enabled. For rust, set the codegen option force-frame-pointers=yes. For C/C++ gcc/clang, set -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from callstack" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "flat" -d 'Faster flat profiling that only records currently executing function'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "callstack" -d 'Slower callstack profiling that records the executing function and all callers'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand profile; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand serve" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand serve" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand serve" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand serve" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand serve" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand serve" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand serve" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l core -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -s o -l output -d 'File to output binary data to' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -s f -l format -d 'Format of the outputted binary data' -r -f -a "ihex\t'Intel Hex Format'
simple-hex\t'Simple list of hexadecimal numbers'
hex-table\t'Hexadecimal numbers formatted into a table'
binary\t'The raw binary'"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand read" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l core -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand write" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and not __fish_seen_subcommand_from install probe-list chip-list help" -l shell -r -f -a "bash\t''
elvish\t''
fish\t''
powershell\t''
zsh\t''"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and not __fish_seen_subcommand_from install probe-list chip-list help" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and not __fish_seen_subcommand_from install probe-list chip-list help" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and not __fish_seen_subcommand_from install probe-list chip-list help" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and not __fish_seen_subcommand_from install probe-list chip-list help" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and not __fish_seen_subcommand_from install probe-list chip-list help" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and not __fish_seen_subcommand_from install probe-list chip-list help" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and not __fish_seen_subcommand_from install probe-list chip-list help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and not __fish_seen_subcommand_from install probe-list chip-list help" -f -a "install" -d 'Installs the autocomplete script for the correct shell'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and not __fish_seen_subcommand_from install probe-list chip-list help" -f -a "probe-list" -d 'Lists the probes that are currently plugged in in a way that the shell understands'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and not __fish_seen_subcommand_from install probe-list chip-list help" -f -a "chip-list" -d 'Lists the chips in a way that the shell understands'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and not __fish_seen_subcommand_from install probe-list chip-list help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from install" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from install" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from install" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from install" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from install" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from install" -s m -l manual -d 'Just print the script to stdout if this flag is active'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from install" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from install" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from probe-list" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from probe-list" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from probe-list" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from probe-list" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from probe-list" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from probe-list" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from probe-list" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from chip-list" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from chip-list" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from chip-list" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from chip-list" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from chip-list" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from chip-list" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from chip-list" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from help" -f -a "install" -d 'Installs the autocomplete script for the correct shell'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from help" -f -a "probe-list" -d 'Lists the probes that are currently plugged in in a way that the shell understands'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from help" -f -a "chip-list" -d 'Lists the chips in a way that the shell understands'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand complete; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and not __fish_seen_subcommand_from meta info help" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and not __fish_seen_subcommand_from meta info help" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and not __fish_seen_subcommand_from meta info help" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and not __fish_seen_subcommand_from meta info help" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and not __fish_seen_subcommand_from meta info help" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and not __fish_seen_subcommand_from meta info help" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and not __fish_seen_subcommand_from meta info help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and not __fish_seen_subcommand_from meta info help" -f -a "meta" -d 'Print probe-rs version and build metadata as JSON'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and not __fish_seen_subcommand_from meta info help" -f -a "info" -d 'Print detected target device information as JSON'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and not __fish_seen_subcommand_from meta info help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from meta" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from meta" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from meta" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from meta" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from meta" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from meta" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from meta" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l chip -x -a "(probe-rs complete chip-list '')"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l chip-description-path -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l protocol -d 'Protocol used to connect to chip. Possible options: [swd, jtag]' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l probe -d 'Use this flag to select a specific probe in the list' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l speed -d 'The protocol speed in kHz' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l attach-timeout -d 'How long to wait for a busy probe, in seconds' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l log-file -d 'Location for log file for probe-rs\'s own debug output' -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -s r -l report -r -F
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l host -d 'Remote host to connect to' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l token -d 'Authentication token for remote connections' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l preset -d 'A configuration preset to apply' -r
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l cycle-power -d 'Whether to cycle usb power before run'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l non-interactive -d 'Disable interactive probe selection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l connect-under-reset -d 'Use this flag to assert the nreset & ntrst pins during attaching the probe to the chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l dry-run
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l allow-erase-all -d 'Use this flag to allow all memory, including security keys and 3rd party firmware, to be erased even when it has read-only protection'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -l log-to-folder -d 'Enable logging of probe-rs\'s own debug data to the default folder. This option is ignored if `--log-file` is specified'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from info" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from help" -f -a "meta" -d 'Print probe-rs version and build metadata as JSON'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from help" -f -a "info" -d 'Print detected target device information as JSON'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand mi; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "dap-server" -d 'Debug Adapter Protocol (DAP) server. See <https://probe.rs/docs/tools/debugger/>'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "list" -d 'List all connected debug probes'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "info" -d 'Gets info about the selected debug probe and connected target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "reset" -d 'Resets the target attached to the selected debug probe'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "gdb" -d 'Run a GDB server'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "debug" -d 'Basic command line debugger'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "download" -d 'Download memory to attached target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "verify" -d 'Compare memory to attached target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "erase" -d 'Erase all nonvolatile memory of attached target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "run" -d 'Flash and run an ELF program'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "attach" -d 'Attach to rtt logging'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "trace" -d 'Trace a memory location on the target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "itm" -d 'Configure and monitor ITM trace packets from the target'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "chip" -d 'Inspect internal registry of supported chips'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "benchmark" -d 'Measure the throughput of the selected debug probe'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "profile" -d 'Profile on-target runtime performance of target ELF program'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "serve" -d 'Start a server that accepts remote connections'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "read" -d 'Read from target memory address'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "write" -d 'Write to target memory address'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "complete" -d 'Install and complete autocomplete scripts'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "mi"
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and not __fish_seen_subcommand_from dap-server list info reset gdb debug download verify erase run attach trace itm chip benchmark profile serve read write complete mi help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and __fish_seen_subcommand_from itm" -f -a "memory" -d 'Direct ITM data to Embedded Trace Buffer/FIFO (ETB/ETF) for extraction'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and __fish_seen_subcommand_from itm" -f -a "swo" -d 'Direct ITM traffic out the TRACESWO pin for reception by the probe'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and __fish_seen_subcommand_from chip" -f -a "list" -d 'Lists all the available families and their chips with their full'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and __fish_seen_subcommand_from chip" -f -a "info" -d 'Shows chip properties of a specific chip'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and __fish_seen_subcommand_from profile" -f -a "flat" -d 'Faster flat profiling that only records currently executing function'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and __fish_seen_subcommand_from profile" -f -a "callstack" -d 'Slower callstack profiling that records the executing function and all callers'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and __fish_seen_subcommand_from complete" -f -a "install" -d 'Installs the autocomplete script for the correct shell'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and __fish_seen_subcommand_from complete" -f -a "probe-list" -d 'Lists the probes that are currently plugged in in a way that the shell understands'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and __fish_seen_subcommand_from complete" -f -a "chip-list" -d 'Lists the chips in a way that the shell understands'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and __fish_seen_subcommand_from mi" -f -a "meta" -d 'Print probe-rs version and build metadata as JSON'
complete -c probe-rs -n "__fish_probe_rs_using_subcommand help; and __fish_seen_subcommand_from mi" -f -a "info" -d 'Print detected target device information as JSON'
