complete -c pix -f -o ide -d 'Open in Zed and run pix in its terminal'
complete -c pix -n 'test (count (string match -v -- "-*" (commandline -xpc))) -eq 1' -f -a '(path basename ~/Documents/Espressif/esp-rs/*/ ~/Documents/Crimpdeq/*/)'
