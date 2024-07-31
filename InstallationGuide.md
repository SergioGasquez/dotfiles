# Installation Guide
Notes to install Windows alongside Arch Linux (using GNOME)

## Requirements

- Windows USB set with [Windows tool](https://www.microsoft.com/es-es/software-download/windows11)
- [Arch Linux ISO](https://archlinux.org/download/) set with [Rufus](https://rufus.ie/)
    - Partition Scheme: `MBR`
- BIOS configured:
    - Disable fast boot: Advanced Mode > Boot > Boot Configuration >  Fast Boot > Disabled
    - Disable CSM:  Advanced Mode > Boot > CSM > Launch CSM > Disabled
    - Configure Secure boot:
        - Advanced Mode > Boot > Secure Boot > OS Type > Other OS
        - Advanced Mode > Boot > Secure Boot > Secure Boot Mode > Custom
    - Make sure that RAM is using the right profile.
        - This might require using latest BIOS FW, otherwise, it might result in the OS crashing
            - For Windows, it is a blue screen
            - For Linux, it just froze

# Windows Installation

1. Install with custom installation
2. Delete all partitions
3. Allocate memory for your Windows partition
4. Allocate the unallocated space into an empty partition, which will be later used for Arch
5. Finish installation
6. Disable Fast Boot from Windows
    1. Settings > System > Power & Sleep > Additional power settings > Choose what power buttons do > Untick Fast Boot

# [Arch Installation](https://wiki.archlinux.org/title/installation_guide)

## Pre-Installation

1. Boot the USB
2. Set the console keyboard layout: `loadkeys es`
3. Verify the boot mode: `ls /sys/firmware/efi/efivars`
    1. If the command shows the directory without error, then the system is booted in UEFI mode. If the directory does not exist, the system may be booted in BIOS (or CSM) mode.
4. Connect to the internet:
    1. Verify that your connection is up: `ip link`
        1. If the desired interface does not show as up: `ip set dev <interface> up`
5. Update the system clock: `timedatectl`
6. List disk partitions: `fdisk -l`. We need to identify the following partitions:
    1. An EFI System partition: It should have been generated during Windows installation (usually *`sda1` or `nvme0n1p1`*)
    2. A root partition: The free partition that we made during Windows installation with type labeled as “Microsoft basic data” (usually *`sda5` or `nvme0n1p5`*)
7. Format the disk partition: `mkfs.ext4 /dev/<root_partition>`
8. Mount the file systems:
    1. Root partition: `mount /dev/<root_partition> /mnt`
    2. EFI partition: `mount --mkdir /dev/<efi_partition> /mnt/efi`

## Installation

1. Install essential packages: `pacstrap -K /mnt base linux linux-firmware`

## Configure the System

1. Fstab: `genfstab -U /mnt >> /mnt/etc/fstab`
    > The fstab file can be used to define how disk partitions, various other block devices, or remote file systems should be mounted into the file system.
2. Chroot: `arch-chroot /mnt`
    > chroot is an operation that changes the apparent root directory for the current running process and their children.
3. Time zone:
    1. `ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime`
    2. `hwclock --systohc`
4. Install nano: `pacman -S nano`
5. Localization:
    1. Edit `/etc/locale.gen`: `nano /etc/locale.gen`
        1. Uncomment `en_US.UTF-8 UTF-8`
    2. Generate the locales:
     `locale-gen`
    3. Create the `locale.conf` file, and set the LANG variable accordingly:
        1. `nano /etc/locale.conf`
            > LANG=en_US.UTF-8
    4. Set console keyboard layout:
        1. `nano /etc/vconsole.conf`
            > KEYMAP=es
6. Network Configuration
    1. Create the hostname file:
        1. `nano /etc/hostname`
            > Zephyr
    2. Install and set NetworkManager:
        1. `pacman  -S networkmanager`
        2. `systemctl enable NetworkManager`
7. Recreate the initramfs image: `mkinitcpio -P`
8. Set the root password: `passwd`
1. Configure the bootloader, [GRUB](https://wiki.archlinux.org/title/GRUB#Installation_2)
    1. Install the necessary packages: `pacman -S grub os-prober efibootmgr`
    2. [To recognize other OSs](https://wiki.archlinux.org/title/GRUB#Detecting_other_operating_systems), edit `/etc/default/grub` and add/uncomment:
    `GRUB_DISABLE_OS_PROBER=false`
    3. Mount EFI partition:`mount /dev/<efi_partition> /efi`
        1. This may be not required since its already mounted
    4. Install GRUB EFI application: `grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB`
    5. Use the grub-mkconfig tool to generate `/boot/grub/grub.cfg`: `grub-mkconfig -o /boot/grub/grub.cfg`
2.  Enable [Microcode](https://wiki.archlinux.org/title/Microcode)
    1. Install the correct package intel/amd) : `pacman -S amd-ucode`
    2. Reconfigure GRUB: `grub-mkconfig -o /boot/grub/grub.cfg`
3.  Exit arch: *Ctrl + d*
4.  Unmount partitions: `umount -R /mnt`
5.  Reboot
6.  Log in with: *root - <password>*

## Post-Installation: [General Recommendations](https://wiki.archlinux.org/title/General_recommendations)

### System Administration

1. Add your user to a group : `useradd -m -G wheel -s /bin/bash sergio`
2. Set a password: `passwd sergio`
3. Set up sudo:
    1. Install the package: `pacman -S sudo`
    2. Configure it: `EDITOR=nano visudo`
        1. Uncomment the line: `%wheel ALL=(ALL:ALL) ALL`

### Graphical User Interface

1. Display server, [Xorg](https://wiki.archlinux.org/title/Xorg) or [Wayland](https://wayland.freedesktop.org/)
    1. Identify your GPU: `lspci -v | grep -A1 -e VGA -e 3D`
    2. Install the proper drivers: `pacman -S nvidia nvidia-utils`
        > For the **[Turing (NV160/TU*XXX*)](https://nouveau.freedesktop.org/CodeNames.html#NV160)** series or newer the **[nvidia-open](https://archlinux.org/packages/?name=nvidia-open)** package may be installed for open source kernel modules on the **[linux](https://archlinux.org/packages/?name=linux)** kernel (On other kernels **[nvidia-open-dkms](https://archlinux.org/packages/?name=nvidia-open-dkms)** must be used).

    3. Install a display server:
        - Wayland: `pacman -S wayland weston`
        - Xorg: `pacman -S xorg-server xorg-apps`
2. Desktop environment, [GNOME](https://wiki.archlinux.org/title/GNOME)
    1. Install the necessary packages `pacman -S gnome gnome-extra`
        1. Use default config
    2. Enable it: `systemctl enable gdm.service`
    3. Reboot

## Fine-Tuning
### Linux
#### Keyboard Layout
1. Settings > Keyboard > Add "Spanish" input source and remove the others
#### Bluetooth
1. Install necessary packages for [blueetooth](https://wiki.archlinux.org/title/bluetooth) ([pulseaudio](https://wiki.archlinux.org/title/bluetooth_headset#Headset_via_Bluez5/PulseAudio) and `bluedoid` might also be required):
    ```
    sudo pacman -S pulseaudio pulseaudio-alsa pulseaudio-bluetooth blueberry bluez bluez-utils
    ```
2. Enable and start the service
    ```
    systemctl start bluetooth.service
    systemctl enable bluetooth.service
    ```
#### AUR Helper
- [paru](https://github.com/Morganamilo/paru/)
- [yay](https://github.com/Jguer/yay#source)
  - Uncomment `Color` option from `/etc/pacman.conf`
#### Grub Customization
- Use Grub Customizer to rename the entries and order
- Change [grub-theme](https://github.com/vinceliuice/grub2-themes):
  ```
  git clone https://github.com/vinceliuice/grub2-themes
  cd grub2-themes
  sudo ./install.sh -t vimix -b
  ```
#### Keyboard Shortcuts
1. Go to Settings > Keyboard Shortcuts > View and Customize Shortcuts
   1. Settings > Keyboard Shortcuts> Set "Switch windows" to `Alt+Tab`.
   2. Set `Ctrl+Alt+T` to open `alacritty`.
#### [Change Mirrors](https://wiki.archlinux.org/title/installation_guide#Select_the_mirrors)
1. Install reflector: `sudo pacman -S reflector rsync`
2. Sort the 30 most recently synchronized mirrors by download speed and overwrite the local mirrorlist: `sudo reflector --latest 50 --sort rate --save /etc/pacman.d/mirrorlist`
#### Fix `espflash` "Permission Denied" or "Port doesn’t exist" errors
1. Run: `sudo usermod -a -G "$(stat -c "%G" /dev/ttyUSB0)" $USER`
   - Port may need to be updated
#### [Setup Docker](https://docs.docker.com/engine/install/linux-postinstall/)
1. Enable the daemon: `systemctl enable docker`
2. Create the docker group: `sudo groupadd docker`
3. Add your user to the docker group: `sudo usermod -aG docker $USER`
4. Reboot
5. Verify that you can run `docker` commands without `sudo`.
#### `qBitTorrent`
1. Enable Search plugin: View > Search Engine
2. Go to the Search tab. Search plugins> Check for updates.
  1. Install any other plugin
#### Vale Config in VS Code
1. Clone the git repo with vale rules
2. Initialize it: `vale sync`
3. Configure VS Code `vale.valeCLI.config` configuration to point at the `.vale.ini` of the cloned repo.
#### Fix Dualboot Time Issue in Windows:
In Linux:
```
timedatectl set-local-rtc 1 --adjust-system-clock
```
On Windows, make sure the time is automatically set

### Windows
#### Configure Mouse Acceleration
 1. Go to Bluetooth & devices > Mouse > Additional mouse settings
 2. Switch to the **Pointer Options** tab, then untick the **Enhanced pointer precision** box.
#### Update Displays Frequency
 1. Right click on desktop > Display settings > Choose the display > Update the Choose a refresh rate field
#### League of Legends Resets to Full Screen:
 1. Edit  `C:\Riot Games\League of Legends\Config\game.cfg` file
     - Set `WindowMode` to 2 instead of 0
 2. Set  `C:\Riot Games\League of Legends\Config\game.cfg` to read-only
     - Right click > Properties > Check the Read-only attribute
#### `qBitTorrent`
1. Enable Search plugin: View > Search Engine
2. Go to the Search tab. Search plugins > Check for updates.
  1. Install any other plugin
#### [PowerToys](https://github.com/microsoft/PowerToys)
1. Disable `Win+Space` shortcut
    - Open PowerToys > Keyboard manager > Enable it > Remap a shortcut
      - Select: `Win (Left) + Space`
      - To send: `Disable`
#### Nvidia GeForce
1. Disable Performance Overlay: Settings > General > Turn off In-game Overlay


