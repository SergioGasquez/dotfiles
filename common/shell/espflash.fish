# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_espflash_global_optspecs
	string join \n S/skip-update-check h/help V/version
end

function __fish_espflash_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_espflash_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_espflash_using_subcommand
	set -l cmd (__fish_espflash_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c espflash -n "__fish_espflash_needs_command" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_needs_command" -s h -l help -d 'Print help'
complete -c espflash -n "__fish_espflash_needs_command" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "board-info" -d 'Print information about a connected target device'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "checksum-md5" -d 'Calculate the MD5 checksum of the given region'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "completions" -d 'Generate completions for the given shell'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "erase-flash" -d 'Erase Flash entirely'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "erase-parts" -d 'Erase specified partitions'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "erase-region" -d 'Erase specified region'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "flash" -d 'Flash an application in ELF format to a connected target device'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "hold-in-reset" -d 'Hold the target device in reset'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "list-ports" -d 'List serial ports available for flashing'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "monitor" -d 'Open the serial monitor without flashing the connected target device'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "partition-table" -d 'Convert partition tables between CSV and binary format'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "read-flash" -d 'Read SPI flash content'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "reset" -d 'Reset the target device'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "save-image" -d 'Generate a binary application image and save it to a local disk'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "write-bin" -d 'Write a binary file to a specific address in a target device\'s flash'
complete -c espflash -n "__fish_espflash_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c espflash -n "__fish_espflash_using_subcommand board-info" -s a -l after -d 'Reset operation to perform after connecting to the target' -r -f -a "hard-reset\t'The DTR serial control line is used to reset the chip into a normal boot sequence'
no-reset\t'Leaves the chip in the serial bootloader, no reset is performed'
no-reset-no-stub\t'Leaves the chip in the stub bootloader, no reset is performed'"
complete -c espflash -n "__fish_espflash_using_subcommand board-info" -s B -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand board-info" -s b -l before -d 'Reset operation to perform before connecting to the target' -r -f -a "default-reset\t'Uses DTR & RTS serial control lines to try to reset the chip into bootloader mode'
no-reset\t'Skips DTR/RTS control signal assignments and just start sending a serial synchronisation command to the chip'
no-reset-no-sync\t'Skips DTR/RTS control signal assignments and also skips the serial synchronization command'
usb-reset\t'Reset sequence for USB-JTAG-Serial peripheral'"
complete -c espflash -n "__fish_espflash_using_subcommand board-info" -s c -l chip -d 'Target device' -r -f -a "esp32\t'ESP32'
esp32c2\t'ESP32-C2, ESP8684'
esp32c3\t'ESP32-C3, ESP8685'
esp32c6\t'ESP32-C6'
esp32h2\t'ESP32-H2'
esp32p4\t'ESP32-P4'
esp32s2\t'ESP32-S2'
esp32s3\t'ESP32-S3'"
complete -c espflash -n "__fish_espflash_using_subcommand board-info" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand board-info" -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_espflash_using_subcommand board-info" -l list-all-ports -d 'List all available ports'
complete -c espflash -n "__fish_espflash_using_subcommand board-info" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_espflash_using_subcommand board-info" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand board-info" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand board-info" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand checksum-md5" -s a -l after -d 'Reset operation to perform after connecting to the target' -r -f -a "hard-reset\t'The DTR serial control line is used to reset the chip into a normal boot sequence'
no-reset\t'Leaves the chip in the serial bootloader, no reset is performed'
no-reset-no-stub\t'Leaves the chip in the stub bootloader, no reset is performed'"
complete -c espflash -n "__fish_espflash_using_subcommand checksum-md5" -s B -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand checksum-md5" -s b -l before -d 'Reset operation to perform before connecting to the target' -r -f -a "default-reset\t'Uses DTR & RTS serial control lines to try to reset the chip into bootloader mode'
no-reset\t'Skips DTR/RTS control signal assignments and just start sending a serial synchronisation command to the chip'
no-reset-no-sync\t'Skips DTR/RTS control signal assignments and also skips the serial synchronization command'
usb-reset\t'Reset sequence for USB-JTAG-Serial peripheral'"
complete -c espflash -n "__fish_espflash_using_subcommand checksum-md5" -s c -l chip -d 'Target device' -r -f -a "esp32\t'ESP32'
esp32c2\t'ESP32-C2, ESP8684'
esp32c3\t'ESP32-C3, ESP8685'
esp32c6\t'ESP32-C6'
esp32h2\t'ESP32-H2'
esp32p4\t'ESP32-P4'
esp32s2\t'ESP32-S2'
esp32s3\t'ESP32-S3'"
complete -c espflash -n "__fish_espflash_using_subcommand checksum-md5" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand checksum-md5" -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_espflash_using_subcommand checksum-md5" -l list-all-ports -d 'List all available ports'
complete -c espflash -n "__fish_espflash_using_subcommand checksum-md5" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_espflash_using_subcommand checksum-md5" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand checksum-md5" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand checksum-md5" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand completions" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand completions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand completions" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand erase-flash" -s a -l after -d 'Reset operation to perform after connecting to the target' -r -f -a "hard-reset\t'The DTR serial control line is used to reset the chip into a normal boot sequence'
no-reset\t'Leaves the chip in the serial bootloader, no reset is performed'
no-reset-no-stub\t'Leaves the chip in the stub bootloader, no reset is performed'"
complete -c espflash -n "__fish_espflash_using_subcommand erase-flash" -s B -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand erase-flash" -s b -l before -d 'Reset operation to perform before connecting to the target' -r -f -a "default-reset\t'Uses DTR & RTS serial control lines to try to reset the chip into bootloader mode'
no-reset\t'Skips DTR/RTS control signal assignments and just start sending a serial synchronisation command to the chip'
no-reset-no-sync\t'Skips DTR/RTS control signal assignments and also skips the serial synchronization command'
usb-reset\t'Reset sequence for USB-JTAG-Serial peripheral'"
complete -c espflash -n "__fish_espflash_using_subcommand erase-flash" -s c -l chip -d 'Target device' -r -f -a "esp32\t'ESP32'
esp32c2\t'ESP32-C2, ESP8684'
esp32c3\t'ESP32-C3, ESP8685'
esp32c6\t'ESP32-C6'
esp32h2\t'ESP32-H2'
esp32p4\t'ESP32-P4'
esp32s2\t'ESP32-S2'
esp32s3\t'ESP32-S3'"
complete -c espflash -n "__fish_espflash_using_subcommand erase-flash" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand erase-flash" -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_espflash_using_subcommand erase-flash" -l list-all-ports -d 'List all available ports'
complete -c espflash -n "__fish_espflash_using_subcommand erase-flash" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_espflash_using_subcommand erase-flash" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand erase-flash" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand erase-flash" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand erase-parts" -s a -l after -d 'Reset operation to perform after connecting to the target' -r -f -a "hard-reset\t'The DTR serial control line is used to reset the chip into a normal boot sequence'
no-reset\t'Leaves the chip in the serial bootloader, no reset is performed'
no-reset-no-stub\t'Leaves the chip in the stub bootloader, no reset is performed'"
complete -c espflash -n "__fish_espflash_using_subcommand erase-parts" -s B -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand erase-parts" -s b -l before -d 'Reset operation to perform before connecting to the target' -r -f -a "default-reset\t'Uses DTR & RTS serial control lines to try to reset the chip into bootloader mode'
no-reset\t'Skips DTR/RTS control signal assignments and just start sending a serial synchronisation command to the chip'
no-reset-no-sync\t'Skips DTR/RTS control signal assignments and also skips the serial synchronization command'
usb-reset\t'Reset sequence for USB-JTAG-Serial peripheral'"
complete -c espflash -n "__fish_espflash_using_subcommand erase-parts" -s c -l chip -d 'Target device' -r -f -a "esp32\t'ESP32'
esp32c2\t'ESP32-C2, ESP8684'
esp32c3\t'ESP32-C3, ESP8685'
esp32c6\t'ESP32-C6'
esp32h2\t'ESP32-H2'
esp32p4\t'ESP32-P4'
esp32s2\t'ESP32-S2'
esp32s3\t'ESP32-S3'"
complete -c espflash -n "__fish_espflash_using_subcommand erase-parts" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand erase-parts" -l partition-table -d 'Input partition table' -r -F
complete -c espflash -n "__fish_espflash_using_subcommand erase-parts" -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_espflash_using_subcommand erase-parts" -l list-all-ports -d 'List all available ports'
complete -c espflash -n "__fish_espflash_using_subcommand erase-parts" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_espflash_using_subcommand erase-parts" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand erase-parts" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand erase-parts" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand erase-region" -s a -l after -d 'Reset operation to perform after connecting to the target' -r -f -a "hard-reset\t'The DTR serial control line is used to reset the chip into a normal boot sequence'
no-reset\t'Leaves the chip in the serial bootloader, no reset is performed'
no-reset-no-stub\t'Leaves the chip in the stub bootloader, no reset is performed'"
complete -c espflash -n "__fish_espflash_using_subcommand erase-region" -s B -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand erase-region" -s b -l before -d 'Reset operation to perform before connecting to the target' -r -f -a "default-reset\t'Uses DTR & RTS serial control lines to try to reset the chip into bootloader mode'
no-reset\t'Skips DTR/RTS control signal assignments and just start sending a serial synchronisation command to the chip'
no-reset-no-sync\t'Skips DTR/RTS control signal assignments and also skips the serial synchronization command'
usb-reset\t'Reset sequence for USB-JTAG-Serial peripheral'"
complete -c espflash -n "__fish_espflash_using_subcommand erase-region" -s c -l chip -d 'Target device' -r -f -a "esp32\t'ESP32'
esp32c2\t'ESP32-C2, ESP8684'
esp32c3\t'ESP32-C3, ESP8685'
esp32c6\t'ESP32-C6'
esp32h2\t'ESP32-H2'
esp32p4\t'ESP32-P4'
esp32s2\t'ESP32-S2'
esp32s3\t'ESP32-S3'"
complete -c espflash -n "__fish_espflash_using_subcommand erase-region" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand erase-region" -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_espflash_using_subcommand erase-region" -l list-all-ports -d 'List all available ports'
complete -c espflash -n "__fish_espflash_using_subcommand erase-region" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_espflash_using_subcommand erase-region" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand erase-region" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand erase-region" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s a -l after -d 'Reset operation to perform after connecting to the target' -r -f -a "hard-reset\t'The DTR serial control line is used to reset the chip into a normal boot sequence'
no-reset\t'Leaves the chip in the serial bootloader, no reset is performed'
no-reset-no-stub\t'Leaves the chip in the stub bootloader, no reset is performed'"
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s B -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s b -l before -d 'Reset operation to perform before connecting to the target' -r -f -a "default-reset\t'Uses DTR & RTS serial control lines to try to reset the chip into bootloader mode'
no-reset\t'Skips DTR/RTS control signal assignments and just start sending a serial synchronisation command to the chip'
no-reset-no-sync\t'Skips DTR/RTS control signal assignments and also skips the serial synchronization command'
usb-reset\t'Reset sequence for USB-JTAG-Serial peripheral'"
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s c -l chip -d 'Target device' -r -f -a "esp32\t'ESP32'
esp32c2\t'ESP32-C2, ESP8684'
esp32c3\t'ESP32-C3, ESP8685'
esp32c6\t'ESP32-C6'
esp32h2\t'ESP32-H2'
esp32p4\t'ESP32-P4'
esp32s2\t'ESP32-S2'
esp32s3\t'ESP32-S3'"
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s f -l flash-freq -d 'Flash frequency' -r -f -a "12mhz\t'12 MHz'
15mhz\t'15 MHz'
16mhz\t'16 MHz'
20mhz\t'20 MHz'
24mhz\t'24 MHz'
26mhz\t'26 MHz'
30mhz\t'30 MHz'
40mhz\t'40 MHz'
48mhz\t'48 MHz'
60mhz\t'60 MHz'
80mhz\t'80 MHz'"
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s m -l flash-mode -d 'Flash mode to use' -r -f -a "qio\t'Quad I/O (4 pins used for address & data)'
qout\t'Quad Output (4 pins used for data)'
dio\t'Dual I/O (2 pins used for address & data)'
dout\t'Dual Output (2 pins used for data)'"
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s s -l flash-size -d 'Flash size of the target' -r -f -a "256kb\t'256 KB'
512kb\t'512 KB'
1mb\t'1 MB'
2mb\t'2 MB'
4mb\t'4 MB'
8mb\t'8 MB'
16mb\t'16 MB'
32mb\t'32 MB'
64mb\t'64 MB'
128mb\t'128 MB'
256mb\t'256 MB'"
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l erase-parts -d 'Erase partitions by label' -r
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l erase-data-parts -d 'Erase specified data partitions' -r
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s r -l monitor-baud -d 'Baud rate at which to monitor the target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l elf -d 'ELF image to load the symbols from' -r -F
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s L -l log-format -d 'Logging format' -r -f -a "defmt\t'defmt'
serial\t'serial'"
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l processors -d 'External log processors to use (comma separated executables)' -r
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l bootloader -d 'Path to a binary (.bin) bootloader file' -r -F
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l partition-table -d 'Path to a CSV file containing partition table' -r -F
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l partition-table-offset -d 'Partition table offset' -r
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l target-app-partition -d 'Label of target app partition' -r
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l min-chip-rev -d 'Minimum chip revision supported by image, in format: major.minor' -r
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l list-all-ports -d 'List all available ports'
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s M -l monitor -d 'Open a serial monitor after flashing'
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l non-interactive -d 'Avoids asking the user for interactions like resetting the device'
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l no-reset -d 'Avoids restarting the device before monitoring'
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l ram -d 'Load the application to RAM instead of Flash'
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l no-verify -d 'Don\'t verify the flash contents after flashing'
complete -c espflash -n "__fish_espflash_using_subcommand flash" -l no-skip -d 'Don\'t skip flashing of parts with matching checksum'
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand flash" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand hold-in-reset" -s a -l after -d 'Reset operation to perform after connecting to the target' -r -f -a "hard-reset\t'The DTR serial control line is used to reset the chip into a normal boot sequence'
no-reset\t'Leaves the chip in the serial bootloader, no reset is performed'
no-reset-no-stub\t'Leaves the chip in the stub bootloader, no reset is performed'"
complete -c espflash -n "__fish_espflash_using_subcommand hold-in-reset" -s B -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand hold-in-reset" -s b -l before -d 'Reset operation to perform before connecting to the target' -r -f -a "default-reset\t'Uses DTR & RTS serial control lines to try to reset the chip into bootloader mode'
no-reset\t'Skips DTR/RTS control signal assignments and just start sending a serial synchronisation command to the chip'
no-reset-no-sync\t'Skips DTR/RTS control signal assignments and also skips the serial synchronization command'
usb-reset\t'Reset sequence for USB-JTAG-Serial peripheral'"
complete -c espflash -n "__fish_espflash_using_subcommand hold-in-reset" -s c -l chip -d 'Target device' -r -f -a "esp32\t'ESP32'
esp32c2\t'ESP32-C2, ESP8684'
esp32c3\t'ESP32-C3, ESP8685'
esp32c6\t'ESP32-C6'
esp32h2\t'ESP32-H2'
esp32p4\t'ESP32-P4'
esp32s2\t'ESP32-S2'
esp32s3\t'ESP32-S3'"
complete -c espflash -n "__fish_espflash_using_subcommand hold-in-reset" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand hold-in-reset" -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_espflash_using_subcommand hold-in-reset" -l list-all-ports -d 'List all available ports'
complete -c espflash -n "__fish_espflash_using_subcommand hold-in-reset" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_espflash_using_subcommand hold-in-reset" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand hold-in-reset" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand hold-in-reset" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand list-ports" -s a -l list-all-ports -d 'List all available serial ports, instead of just those likely to be development boards. Includes non-usb ports such as PCI devices'
complete -c espflash -n "__fish_espflash_using_subcommand list-ports" -s n -l name-only -d 'Only print the name of the ports and nothing else. Useful for scripting'
complete -c espflash -n "__fish_espflash_using_subcommand list-ports" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand list-ports" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand list-ports" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -s a -l after -d 'Reset operation to perform after connecting to the target' -r -f -a "hard-reset\t'The DTR serial control line is used to reset the chip into a normal boot sequence'
no-reset\t'Leaves the chip in the serial bootloader, no reset is performed'
no-reset-no-stub\t'Leaves the chip in the stub bootloader, no reset is performed'"
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -s B -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -s b -l before -d 'Reset operation to perform before connecting to the target' -r -f -a "default-reset\t'Uses DTR & RTS serial control lines to try to reset the chip into bootloader mode'
no-reset\t'Skips DTR/RTS control signal assignments and just start sending a serial synchronisation command to the chip'
no-reset-no-sync\t'Skips DTR/RTS control signal assignments and also skips the serial synchronization command'
usb-reset\t'Reset sequence for USB-JTAG-Serial peripheral'"
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -s c -l chip -d 'Target device' -r -f -a "esp32\t'ESP32'
esp32c2\t'ESP32-C2, ESP8684'
esp32c3\t'ESP32-C3, ESP8685'
esp32c6\t'ESP32-C6'
esp32h2\t'ESP32-H2'
esp32p4\t'ESP32-P4'
esp32s2\t'ESP32-S2'
esp32s3\t'ESP32-S3'"
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -s r -l monitor-baud -d 'Baud rate at which to monitor the target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -l elf -d 'ELF image to load the symbols from' -r -F
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -s L -l log-format -d 'Logging format' -r -f -a "defmt\t'defmt'
serial\t'serial'"
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -l processors -d 'External log processors to use (comma separated executables)' -r
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -l list-all-ports -d 'List all available ports'
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -l non-interactive -d 'Avoids asking the user for interactions like resetting the device'
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -l no-reset -d 'Avoids restarting the device before monitoring'
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand monitor" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand partition-table" -s o -l output -d 'Optional output file name, if unset will output to stdout' -r -F
complete -c espflash -n "__fish_espflash_using_subcommand partition-table" -l to-binary -d 'Convert CSV partition table to binary representation'
complete -c espflash -n "__fish_espflash_using_subcommand partition-table" -l to-csv -d 'Convert binary partition table to CSV representation'
complete -c espflash -n "__fish_espflash_using_subcommand partition-table" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand partition-table" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand partition-table" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -l block-size -d 'Size of each individual packet of data' -r
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -s a -l after -d 'Reset operation to perform after connecting to the target' -r -f -a "hard-reset\t'The DTR serial control line is used to reset the chip into a normal boot sequence'
no-reset\t'Leaves the chip in the serial bootloader, no reset is performed'
no-reset-no-stub\t'Leaves the chip in the stub bootloader, no reset is performed'"
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -s B -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -s b -l before -d 'Reset operation to perform before connecting to the target' -r -f -a "default-reset\t'Uses DTR & RTS serial control lines to try to reset the chip into bootloader mode'
no-reset\t'Skips DTR/RTS control signal assignments and just start sending a serial synchronisation command to the chip'
no-reset-no-sync\t'Skips DTR/RTS control signal assignments and also skips the serial synchronization command'
usb-reset\t'Reset sequence for USB-JTAG-Serial peripheral'"
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -s c -l chip -d 'Target device' -r -f -a "esp32\t'ESP32'
esp32c2\t'ESP32-C2, ESP8684'
esp32c3\t'ESP32-C3, ESP8685'
esp32c6\t'ESP32-C6'
esp32h2\t'ESP32-H2'
esp32p4\t'ESP32-P4'
esp32s2\t'ESP32-S2'
esp32s3\t'ESP32-S3'"
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -l max-in-flight -d 'Maximum number of un-acked packets' -r
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -l list-all-ports -d 'List all available ports'
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand read-flash" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand reset" -s a -l after -d 'Reset operation to perform after connecting to the target' -r -f -a "hard-reset\t'The DTR serial control line is used to reset the chip into a normal boot sequence'
no-reset\t'Leaves the chip in the serial bootloader, no reset is performed'
no-reset-no-stub\t'Leaves the chip in the stub bootloader, no reset is performed'"
complete -c espflash -n "__fish_espflash_using_subcommand reset" -s B -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand reset" -s b -l before -d 'Reset operation to perform before connecting to the target' -r -f -a "default-reset\t'Uses DTR & RTS serial control lines to try to reset the chip into bootloader mode'
no-reset\t'Skips DTR/RTS control signal assignments and just start sending a serial synchronisation command to the chip'
no-reset-no-sync\t'Skips DTR/RTS control signal assignments and also skips the serial synchronization command'
usb-reset\t'Reset sequence for USB-JTAG-Serial peripheral'"
complete -c espflash -n "__fish_espflash_using_subcommand reset" -s c -l chip -d 'Target device' -r -f -a "esp32\t'ESP32'
esp32c2\t'ESP32-C2, ESP8684'
esp32c3\t'ESP32-C3, ESP8685'
esp32c6\t'ESP32-C6'
esp32h2\t'ESP32-H2'
esp32p4\t'ESP32-P4'
esp32s2\t'ESP32-S2'
esp32s3\t'ESP32-S3'"
complete -c espflash -n "__fish_espflash_using_subcommand reset" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand reset" -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_espflash_using_subcommand reset" -l list-all-ports -d 'List all available ports'
complete -c espflash -n "__fish_espflash_using_subcommand reset" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_espflash_using_subcommand reset" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand reset" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand reset" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -s f -l flash-freq -d 'Flash frequency' -r -f -a "12mhz\t'12 MHz'
15mhz\t'15 MHz'
16mhz\t'16 MHz'
20mhz\t'20 MHz'
24mhz\t'24 MHz'
26mhz\t'26 MHz'
30mhz\t'30 MHz'
40mhz\t'40 MHz'
48mhz\t'48 MHz'
60mhz\t'60 MHz'
80mhz\t'80 MHz'"
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -s m -l flash-mode -d 'Flash mode to use' -r -f -a "qio\t'Quad I/O (4 pins used for address & data)'
qout\t'Quad Output (4 pins used for data)'
dio\t'Dual I/O (2 pins used for address & data)'
dout\t'Dual Output (2 pins used for data)'"
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -s s -l flash-size -d 'Flash size of the target' -r -f -a "256kb\t'256 KB'
512kb\t'512 KB'
1mb\t'1 MB'
2mb\t'2 MB'
4mb\t'4 MB'
8mb\t'8 MB'
16mb\t'16 MB'
32mb\t'32 MB'
64mb\t'64 MB'
128mb\t'128 MB'
256mb\t'256 MB'"
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -l chip -d 'Chip to create an image for' -r -f -a "esp32\t'ESP32'
esp32c2\t'ESP32-C2, ESP8684'
esp32c3\t'ESP32-C3, ESP8685'
esp32c6\t'ESP32-C6'
esp32h2\t'ESP32-H2'
esp32p4\t'ESP32-P4'
esp32s2\t'ESP32-S2'
esp32s3\t'ESP32-S3'"
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -s x -l xtal-freq -d 'Cristal frequency of the target' -r -f -a "26mhz\t'26 MHz'
32mhz\t'32 MHz'
40mhz\t'40 MHz'"
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -l bootloader -d 'Path to a binary (.bin) bootloader file' -r -F
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -l partition-table -d 'Path to a CSV file containing partition table' -r -F
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -l partition-table-offset -d 'Partition table offset' -r
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -l target-app-partition -d 'Label of target app partition' -r
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -l min-chip-rev -d 'Minimum chip revision supported by image, in format: major.minor' -r
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -l merge -d 'Boolean flag to merge binaries into single binary'
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -l skip-padding -d 'Don\'t pad the image to the flash size'
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand save-image" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -s a -l after -d 'Reset operation to perform after connecting to the target' -r -f -a "hard-reset\t'The DTR serial control line is used to reset the chip into a normal boot sequence'
no-reset\t'Leaves the chip in the serial bootloader, no reset is performed'
no-reset-no-stub\t'Leaves the chip in the stub bootloader, no reset is performed'"
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -s B -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -s b -l before -d 'Reset operation to perform before connecting to the target' -r -f -a "default-reset\t'Uses DTR & RTS serial control lines to try to reset the chip into bootloader mode'
no-reset\t'Skips DTR/RTS control signal assignments and just start sending a serial synchronisation command to the chip'
no-reset-no-sync\t'Skips DTR/RTS control signal assignments and also skips the serial synchronization command'
usb-reset\t'Reset sequence for USB-JTAG-Serial peripheral'"
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -s c -l chip -d 'Target device' -r -f -a "esp32\t'ESP32'
esp32c2\t'ESP32-C2, ESP8684'
esp32c3\t'ESP32-C3, ESP8685'
esp32c6\t'ESP32-C6'
esp32h2\t'ESP32-H2'
esp32p4\t'ESP32-P4'
esp32s2\t'ESP32-S2'
esp32s3\t'ESP32-S3'"
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -s r -l monitor-baud -d 'Baud rate at which to monitor the target device' -r
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -l elf -d 'ELF image to load the symbols from' -r -F
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -s L -l log-format -d 'Logging format' -r -f -a "defmt\t'defmt'
serial\t'serial'"
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -l processors -d 'External log processors to use (comma separated executables)' -r
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -l list-all-ports -d 'List all available ports'
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -s M -l monitor -d 'Open a serial monitor after writing'
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -l non-interactive -d 'Avoids asking the user for interactions like resetting the device'
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -l no-reset -d 'Avoids restarting the device before monitoring'
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -s S -l skip-update-check -d 'Do not check for updates'
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_espflash_using_subcommand write-bin" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "board-info" -d 'Print information about a connected target device'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "checksum-md5" -d 'Calculate the MD5 checksum of the given region'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "completions" -d 'Generate completions for the given shell'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "erase-flash" -d 'Erase Flash entirely'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "erase-parts" -d 'Erase specified partitions'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "erase-region" -d 'Erase specified region'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "flash" -d 'Flash an application in ELF format to a connected target device'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "hold-in-reset" -d 'Hold the target device in reset'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "list-ports" -d 'List serial ports available for flashing'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "monitor" -d 'Open the serial monitor without flashing the connected target device'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "partition-table" -d 'Convert partition tables between CSV and binary format'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "read-flash" -d 'Read SPI flash content'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "reset" -d 'Reset the target device'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "save-image" -d 'Generate a binary application image and save it to a local disk'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "write-bin" -d 'Write a binary file to a specific address in a target device\'s flash'
complete -c espflash -n "__fish_espflash_using_subcommand help; and not __fish_seen_subcommand_from board-info checksum-md5 completions erase-flash erase-parts erase-region flash hold-in-reset list-ports monitor partition-table read-flash reset save-image write-bin help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
