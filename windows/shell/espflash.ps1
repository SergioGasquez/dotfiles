complete -c espflash -n "__fish_use_subcommand" -s h -l help -d 'Print help'
complete -c espflash -n "__fish_use_subcommand" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_use_subcommand" -f -a "board-info" -d 'Print information about a connected target device'
complete -c espflash -n "__fish_use_subcommand" -f -a "completions" -d 'Generate completions for the given shell'
complete -c espflash -n "__fish_use_subcommand" -f -a "erase-flash" -d 'Erase Flash entirely'
complete -c espflash -n "__fish_use_subcommand" -f -a "erase-parts" -d 'Erase specified partitions'
complete -c espflash -n "__fish_use_subcommand" -f -a "erase-region" -d 'Erase specified region'
complete -c espflash -n "__fish_use_subcommand" -f -a "flash" -d 'Flash an application in ELF format to a connected target device'
complete -c espflash -n "__fish_use_subcommand" -f -a "monitor" -d 'Open the serial monitor without flashing the connected target device'
complete -c espflash -n "__fish_use_subcommand" -f -a "partition-table" -d 'Convert partition tables between CSV and binary format'
complete -c espflash -n "__fish_use_subcommand" -f -a "save-image" -d 'Generate a binary application image and save it to a local disk'
complete -c espflash -n "__fish_use_subcommand" -f -a "write-bin" -d 'Write a binary file to a specific address in a target device\'s flash'
complete -c espflash -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c espflash -n "__fish_seen_subcommand_from board-info" -s b -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_seen_subcommand_from board-info" -s c -l chip -d 'Target device' -r -f -a "{esp32	'ESP32',esp32c2	'ESP32-C2, ESP8684',esp32c3	'ESP32-C3, ESP8685',esp32c6	'ESP32-C6',esp32s2	'ESP32-S2',esp32s3	'ESP32-S3',esp32h2	'ESP32-H2',esp8266	'ESP8266'}"
complete -c espflash -n "__fish_seen_subcommand_from board-info" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_seen_subcommand_from board-info" -s C -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_seen_subcommand_from board-info" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_seen_subcommand_from board-info" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_seen_subcommand_from board-info" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_seen_subcommand_from completions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_seen_subcommand_from completions" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_seen_subcommand_from erase-flash" -s b -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_seen_subcommand_from erase-flash" -s c -l chip -d 'Target device' -r -f -a "{esp32	'ESP32',esp32c2	'ESP32-C2, ESP8684',esp32c3	'ESP32-C3, ESP8685',esp32c6	'ESP32-C6',esp32s2	'ESP32-S2',esp32s3	'ESP32-S3',esp32h2	'ESP32-H2',esp8266	'ESP8266'}"
complete -c espflash -n "__fish_seen_subcommand_from erase-flash" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_seen_subcommand_from erase-flash" -s C -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_seen_subcommand_from erase-flash" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_seen_subcommand_from erase-flash" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_seen_subcommand_from erase-flash" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_seen_subcommand_from erase-parts" -s b -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_seen_subcommand_from erase-parts" -s c -l chip -d 'Target device' -r -f -a "{esp32	'ESP32',esp32c2	'ESP32-C2, ESP8684',esp32c3	'ESP32-C3, ESP8685',esp32c6	'ESP32-C6',esp32s2	'ESP32-S2',esp32s3	'ESP32-S3',esp32h2	'ESP32-H2',esp8266	'ESP8266'}"
complete -c espflash -n "__fish_seen_subcommand_from erase-parts" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_seen_subcommand_from erase-parts" -l partition-table -d 'Input partition table' -r -F
complete -c espflash -n "__fish_seen_subcommand_from erase-parts" -s C -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_seen_subcommand_from erase-parts" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_seen_subcommand_from erase-parts" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_seen_subcommand_from erase-parts" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_seen_subcommand_from erase-region" -s b -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_seen_subcommand_from erase-region" -s c -l chip -d 'Target device' -r -f -a "{esp32	'ESP32',esp32c2	'ESP32-C2, ESP8684',esp32c3	'ESP32-C3, ESP8685',esp32c6	'ESP32-C6',esp32s2	'ESP32-S2',esp32s3	'ESP32-S3',esp32h2	'ESP32-H2',esp8266	'ESP8266'}"
complete -c espflash -n "__fish_seen_subcommand_from erase-region" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_seen_subcommand_from erase-region" -s C -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_seen_subcommand_from erase-region" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_seen_subcommand_from erase-region" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_seen_subcommand_from erase-region" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_seen_subcommand_from flash" -s b -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_seen_subcommand_from flash" -s c -l chip -d 'Target device' -r -f -a "{esp32	'ESP32',esp32c2	'ESP32-C2, ESP8684',esp32c3	'ESP32-C3, ESP8685',esp32c6	'ESP32-C6',esp32s2	'ESP32-S2',esp32s3	'ESP32-S3',esp32h2	'ESP32-H2',esp8266	'ESP8266'}"
complete -c espflash -n "__fish_seen_subcommand_from flash" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_seen_subcommand_from flash" -s f -l flash-freq -d 'Flash frequency' -r -f -a "{12mhz	'12 MHz',15mhz	'15 MHz',16mhz	'16 MHz',20mhz	'20 MHz',24mhz	'24 MHz',26mhz	'26 MHz',30mhz	'30 MHz',40mhz	'40 MHz',48mhz	'48 MHz',60mhz	'60 MHz',80mhz	'80 MHz'}"
complete -c espflash -n "__fish_seen_subcommand_from flash" -s m -l flash-mode -d 'Flash mode to use' -r -f -a "{qio	'Quad I/O (4 pins used for address & data)',qout	'Quad Output (4 pins used for data)',dio	'Dual I/O (2 pins used for address & data)',dout	'Dual Output (2 pins used for data)'}"
complete -c espflash -n "__fish_seen_subcommand_from flash" -s s -l flash-size -d 'Flash size of the target' -r -f -a "{256kb	'256 KB',512kb	'512 KB',1mb	'1 MB',2mb	'2 MB',4mb	'4 MB',8mb	'8 MB',16mb	'16 MB',32mb	'32 MB',64mb	'64 MB',128mb	'128 MB',256mb	'256 MB'}"
complete -c espflash -n "__fish_seen_subcommand_from flash" -l bootloader -d 'Path to a binary (.bin) bootloader file' -r -F
complete -c espflash -n "__fish_seen_subcommand_from flash" -l erase-parts -d 'Erase partitions by label' -r
complete -c espflash -n "__fish_seen_subcommand_from flash" -l erase-data-parts -d 'Erase specified data partitions' -r
complete -c espflash -n "__fish_seen_subcommand_from flash" -l format -d 'Image format to flash' -r -f -a "{esp-bootloader	'Use the second-stage bootloader from ESP-IDF',direct-boot	'Use direct boot and do not use a second-stage bootloader at all'}"
complete -c espflash -n "__fish_seen_subcommand_from flash" -s L -l log-format -d 'Logging format' -r -f -a "{defmt	'defmt',serial	'serial'}"
complete -c espflash -n "__fish_seen_subcommand_from flash" -l monitor-baud -d 'Baud rate at which to read console output' -r
complete -c espflash -n "__fish_seen_subcommand_from flash" -l partition-table -d 'Path to a CSV file containing partition table' -r -F
complete -c espflash -n "__fish_seen_subcommand_from flash" -l target-app-partition -d 'Label of target app partition' -r
complete -c espflash -n "__fish_seen_subcommand_from flash" -l partition-table-offset -d 'Partition table offset' -r
complete -c espflash -n "__fish_seen_subcommand_from flash" -s C -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_seen_subcommand_from flash" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_seen_subcommand_from flash" -s M -l monitor -d 'Open a serial monitor after flashing'
complete -c espflash -n "__fish_seen_subcommand_from flash" -l ram -d 'Load the application to RAM instead of Flash'
complete -c espflash -n "__fish_seen_subcommand_from flash" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_seen_subcommand_from flash" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_seen_subcommand_from monitor" -s b -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_seen_subcommand_from monitor" -s c -l chip -d 'Target device' -r -f -a "{esp32	'ESP32',esp32c2	'ESP32-C2, ESP8684',esp32c3	'ESP32-C3, ESP8685',esp32c6	'ESP32-C6',esp32s2	'ESP32-S2',esp32s3	'ESP32-S3',esp32h2	'ESP32-H2',esp8266	'ESP8266'}"
complete -c espflash -n "__fish_seen_subcommand_from monitor" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_seen_subcommand_from monitor" -s e -l elf -d 'Optional file name of the ELF image to load the symbols from' -r -F
complete -c espflash -n "__fish_seen_subcommand_from monitor" -s L -l log-format -d 'Logging format' -r -f -a "{defmt	'defmt',serial	'serial'}"
complete -c espflash -n "__fish_seen_subcommand_from monitor" -s C -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_seen_subcommand_from monitor" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_seen_subcommand_from monitor" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_seen_subcommand_from monitor" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_seen_subcommand_from partition-table" -s o -l output -d 'Optional output file name, if unset will output to stdout' -r -F
complete -c espflash -n "__fish_seen_subcommand_from partition-table" -l to-binary -d 'Convert CSV partition table to binary representation'
complete -c espflash -n "__fish_seen_subcommand_from partition-table" -l to-csv -d 'Convert binary partition table to CSV representation'
complete -c espflash -n "__fish_seen_subcommand_from partition-table" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_seen_subcommand_from partition-table" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_seen_subcommand_from save-image" -l format -d 'Image format to flash' -r -f -a "{esp-bootloader	'Use the second-stage bootloader from ESP-IDF',direct-boot	'Use direct boot and do not use a second-stage bootloader at all'}"
complete -c espflash -n "__fish_seen_subcommand_from save-image" -s f -l flash-freq -d 'Flash frequency' -r -f -a "{12mhz	'12 MHz',15mhz	'15 MHz',16mhz	'16 MHz',20mhz	'20 MHz',24mhz	'24 MHz',26mhz	'26 MHz',30mhz	'30 MHz',40mhz	'40 MHz',48mhz	'48 MHz',60mhz	'60 MHz',80mhz	'80 MHz'}"
complete -c espflash -n "__fish_seen_subcommand_from save-image" -s m -l flash-mode -d 'Flash mode to use' -r -f -a "{qio	'Quad I/O (4 pins used for address & data)',qout	'Quad Output (4 pins used for data)',dio	'Dual I/O (2 pins used for address & data)',dout	'Dual Output (2 pins used for data)'}"
complete -c espflash -n "__fish_seen_subcommand_from save-image" -s s -l flash-size -d 'Flash size of the target' -r -f -a "{256kb	'256 KB',512kb	'512 KB',1mb	'1 MB',2mb	'2 MB',4mb	'4 MB',8mb	'8 MB',16mb	'16 MB',32mb	'32 MB',64mb	'64 MB',128mb	'128 MB',256mb	'256 MB'}"
complete -c espflash -n "__fish_seen_subcommand_from save-image" -l bootloader -d 'Custom bootloader for merging' -r -F
complete -c espflash -n "__fish_seen_subcommand_from save-image" -l chip -d 'Chip to create an image for' -r -f -a "{esp32	'ESP32',esp32c2	'ESP32-C2, ESP8684',esp32c3	'ESP32-C3, ESP8685',esp32c6	'ESP32-C6',esp32s2	'ESP32-S2',esp32s3	'ESP32-S3',esp32h2	'ESP32-H2',esp8266	'ESP8266'}"
complete -c espflash -n "__fish_seen_subcommand_from save-image" -s T -l partition-table -d 'Custom partition table for merging' -r -F
complete -c espflash -n "__fish_seen_subcommand_from save-image" -l partition-table-offset -d 'Partition table offset' -r
complete -c espflash -n "__fish_seen_subcommand_from save-image" -l target-app-partition -d 'Label of target app partition' -r
complete -c espflash -n "__fish_seen_subcommand_from save-image" -l merge -d 'Boolean flag to merge binaries into single binary'
complete -c espflash -n "__fish_seen_subcommand_from save-image" -s P -l skip-padding -d 'Don\'t pad the image to the flash size'
complete -c espflash -n "__fish_seen_subcommand_from save-image" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_seen_subcommand_from save-image" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_seen_subcommand_from write-bin" -s b -l baud -d 'Baud rate at which to communicate with target device' -r
complete -c espflash -n "__fish_seen_subcommand_from write-bin" -s c -l chip -d 'Target device' -r -f -a "{esp32	'ESP32',esp32c2	'ESP32-C2, ESP8684',esp32c3	'ESP32-C3, ESP8685',esp32c6	'ESP32-C6',esp32s2	'ESP32-S2',esp32s3	'ESP32-S3',esp32h2	'ESP32-H2',esp8266	'ESP8266'}"
complete -c espflash -n "__fish_seen_subcommand_from write-bin" -s p -l port -d 'Serial port connected to target device' -r
complete -c espflash -n "__fish_seen_subcommand_from write-bin" -s C -l confirm-port -d 'Require confirmation before auto-connecting to a recognized device'
complete -c espflash -n "__fish_seen_subcommand_from write-bin" -l no-stub -d 'Do not use the RAM stub for loading'
complete -c espflash -n "__fish_seen_subcommand_from write-bin" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c espflash -n "__fish_seen_subcommand_from write-bin" -s V -l version -d 'Print version'
complete -c espflash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from board-info; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from erase-flash; and not __fish_seen_subcommand_from erase-parts; and not __fish_seen_subcommand_from erase-region; and not __fish_seen_subcommand_from flash; and not __fish_seen_subcommand_from monitor; and not __fish_seen_subcommand_from partition-table; and not __fish_seen_subcommand_from save-image; and not __fish_seen_subcommand_from write-bin; and not __fish_seen_subcommand_from help" -f -a "board-info" -d 'Print information about a connected target device'
complete -c espflash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from board-info; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from erase-flash; and not __fish_seen_subcommand_from erase-parts; and not __fish_seen_subcommand_from erase-region; and not __fish_seen_subcommand_from flash; and not __fish_seen_subcommand_from monitor; and not __fish_seen_subcommand_from partition-table; and not __fish_seen_subcommand_from save-image; and not __fish_seen_subcommand_from write-bin; and not __fish_seen_subcommand_from help" -f -a "completions" -d 'Generate completions for the given shell'
complete -c espflash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from board-info; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from erase-flash; and not __fish_seen_subcommand_from erase-parts; and not __fish_seen_subcommand_from erase-region; and not __fish_seen_subcommand_from flash; and not __fish_seen_subcommand_from monitor; and not __fish_seen_subcommand_from partition-table; and not __fish_seen_subcommand_from save-image; and not __fish_seen_subcommand_from write-bin; and not __fish_seen_subcommand_from help" -f -a "erase-flash" -d 'Erase Flash entirely'
complete -c espflash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from board-info; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from erase-flash; and not __fish_seen_subcommand_from erase-parts; and not __fish_seen_subcommand_from erase-region; and not __fish_seen_subcommand_from flash; and not __fish_seen_subcommand_from monitor; and not __fish_seen_subcommand_from partition-table; and not __fish_seen_subcommand_from save-image; and not __fish_seen_subcommand_from write-bin; and not __fish_seen_subcommand_from help" -f -a "erase-parts" -d 'Erase specified partitions'
complete -c espflash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from board-info; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from erase-flash; and not __fish_seen_subcommand_from erase-parts; and not __fish_seen_subcommand_from erase-region; and not __fish_seen_subcommand_from flash; and not __fish_seen_subcommand_from monitor; and not __fish_seen_subcommand_from partition-table; and not __fish_seen_subcommand_from save-image; and not __fish_seen_subcommand_from write-bin; and not __fish_seen_subcommand_from help" -f -a "erase-region" -d 'Erase specified region'
complete -c espflash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from board-info; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from erase-flash; and not __fish_seen_subcommand_from erase-parts; and not __fish_seen_subcommand_from erase-region; and not __fish_seen_subcommand_from flash; and not __fish_seen_subcommand_from monitor; and not __fish_seen_subcommand_from partition-table; and not __fish_seen_subcommand_from save-image; and not __fish_seen_subcommand_from write-bin; and not __fish_seen_subcommand_from help" -f -a "flash" -d 'Flash an application in ELF format to a connected target device'
complete -c espflash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from board-info; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from erase-flash; and not __fish_seen_subcommand_from erase-parts; and not __fish_seen_subcommand_from erase-region; and not __fish_seen_subcommand_from flash; and not __fish_seen_subcommand_from monitor; and not __fish_seen_subcommand_from partition-table; and not __fish_seen_subcommand_from save-image; and not __fish_seen_subcommand_from write-bin; and not __fish_seen_subcommand_from help" -f -a "monitor" -d 'Open the serial monitor without flashing the connected target device'
complete -c espflash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from board-info; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from erase-flash; and not __fish_seen_subcommand_from erase-parts; and not __fish_seen_subcommand_from erase-region; and not __fish_seen_subcommand_from flash; and not __fish_seen_subcommand_from monitor; and not __fish_seen_subcommand_from partition-table; and not __fish_seen_subcommand_from save-image; and not __fish_seen_subcommand_from write-bin; and not __fish_seen_subcommand_from help" -f -a "partition-table" -d 'Convert partition tables between CSV and binary format'
complete -c espflash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from board-info; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from erase-flash; and not __fish_seen_subcommand_from erase-parts; and not __fish_seen_subcommand_from erase-region; and not __fish_seen_subcommand_from flash; and not __fish_seen_subcommand_from monitor; and not __fish_seen_subcommand_from partition-table; and not __fish_seen_subcommand_from save-image; and not __fish_seen_subcommand_from write-bin; and not __fish_seen_subcommand_from help" -f -a "save-image" -d 'Generate a binary application image and save it to a local disk'
complete -c espflash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from board-info; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from erase-flash; and not __fish_seen_subcommand_from erase-parts; and not __fish_seen_subcommand_from erase-region; and not __fish_seen_subcommand_from flash; and not __fish_seen_subcommand_from monitor; and not __fish_seen_subcommand_from partition-table; and not __fish_seen_subcommand_from save-image; and not __fish_seen_subcommand_from write-bin; and not __fish_seen_subcommand_from help" -f -a "write-bin" -d 'Write a binary file to a specific address in a target device\'s flash'
complete -c espflash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from board-info; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from erase-flash; and not __fish_seen_subcommand_from erase-parts; and not __fish_seen_subcommand_from erase-region; and not __fish_seen_subcommand_from flash; and not __fish_seen_subcommand_from monitor; and not __fish_seen_subcommand_from partition-table; and not __fish_seen_subcommand_from save-image; and not __fish_seen_subcommand_from write-bin; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
