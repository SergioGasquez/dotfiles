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

### Pre-installation

1. Boot the Arch USB in UEFI mode.
2. Set the console keyboard layout:
   ```bash
   loadkeys es
   ```
3. Verify UEFI mode. If this directory does not exist, reboot and select the
   UEFI entry for the USB:
   ```bash
   ls /sys/firmware/efi/efivars
   ```
4. Connect to the internet and verify the interface state:
   ```bash
   ip link
   ip link set dev <interface> up
   ```
   Use `iwctl` when a Wi-Fi connection must be configured.
5. Verify the system clock:
   ```bash
   timedatectl
   ```
6. Inspect the partition table:
   ```bash
   fdisk -l
   ```
   Identify the existing EFI System Partition created by Windows. Create a
   Linux root partition in the unallocated space with `fdisk` or `cfdisk`.
   Do not format the EFI System Partition.
7. Format only the new Linux root partition:
   ```bash
   mkfs.ext4 /dev/<root_partition>
   ```
8. Mount the root and existing EFI partitions:
   ```bash
   mount /dev/<root_partition> /mnt
   mount --mkdir /dev/<efi_partition> /mnt/efi
   ```

### Install the base system

Install the base system and the tools required by the dotfiles setup:

```bash
pacstrap -K /mnt base base-devel linux linux-firmware \
    curl git nano networkmanager sudo
```

### Configure the system

1. Generate `fstab`:
   ```bash
   genfstab -U /mnt >> /mnt/etc/fstab
   ```
2. Enter the installed system:
   ```bash
   arch-chroot /mnt
   ```
3. Configure the time zone:
   ```bash
   ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
   hwclock --systohc
   ```
4. Uncomment `en_US.UTF-8 UTF-8` in `/etc/locale.gen`, then configure the
   locale and console keyboard:
   ```bash
   locale-gen
   echo 'LANG=en_US.UTF-8' > /etc/locale.conf
   echo 'KEYMAP=es' > /etc/vconsole.conf
   ```
5. Set the machine-specific hostname:
   ```bash
   echo '<hostname>' > /etc/hostname
   ```
6. Enable networking:
   ```bash
   systemctl enable NetworkManager
   ```
7. Recreate the initramfs and set the root password:
   ```bash
   mkinitcpio -P
   passwd
   ```
8. Create the regular user and configure `sudo`:
   ```bash
   useradd -m -G wheel -s /bin/bash <username>
   passwd <username>
   EDITOR=nano visudo
   ```
   Uncomment `%wheel ALL=(ALL:ALL) ALL`.

### Configure GRUB and microcode

1. Install GRUB and its UEFI dependencies:
   ```bash
   pacman -S grub efibootmgr os-prober
   ```
2. Set `GRUB_DISABLE_OS_PROBER=false` in `/etc/default/grub`.
3. Install GRUB and generate its configuration:
   ```bash
   grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
   grub-mkconfig -o /boot/grub/grub.cfg
   ```
4. Install the [microcode](https://wiki.archlinux.org/title/Microcode) package
   matching the CPU:
   ```bash
   pacman -S intel-ucode  # Intel
   pacman -S amd-ucode    # AMD
   ```
   Run only the applicable command, then regenerate GRUB:
   ```bash
   grub-mkconfig -o /boot/grub/grub.cfg
   ```
5. Exit, unmount, and reboot:
   ```bash
   exit
   umount -R /mnt
   reboot
   ```

## Post-installation

### Graphical environment

1. Identify the GPU:
   ```bash
   lspci -v | grep -A1 -E 'VGA|3D'
   ```
2. Install the driver appropriate for that exact GPU. Consult the
   [ArchWiki graphics documentation](https://wiki.archlinux.org/title/Xorg#Driver_installation)
   instead of installing a vendor-specific package unconditionally.
3. Install GNOME and the current PipeWire audio stack:
   ```bash
   sudo pacman -S gnome pipewire pipewire-audio pipewire-pulse wireplumber
   sudo systemctl enable gdm
   ```
   GNOME uses Wayland by default; Weston is not required. Install
   `xorg-server` only when an Xorg session is needed.
4. Reboot.

### Linux fine-tuning

#### Keyboard and workspaces

- Settings > Keyboard > add the Spanish input source and remove unused ones.
- Settings > Multitasking > Multi-Monitor > Workspaces on all displays.
- Settings > Keyboard Shortcuts > set **Switch windows** to `Alt+Tab`.
- Add `Ctrl+Alt+T` as a shortcut for `alacritty`.

#### Bluetooth

Use PipeWire rather than replacing it with PulseAudio:

```bash
sudo pacman -S bluez bluez-utils
sudo systemctl enable --now bluetooth
```

Configure devices through GNOME Settings. See the
[ArchWiki Bluetooth documentation](https://wiki.archlinux.org/title/Bluetooth)
for troubleshooting.

#### AUR helper

Install [paru](https://github.com/Morganamilo/paru):

```bash
git clone https://aur.archlinux.org/paru.git /tmp/paru
(cd /tmp/paru && makepkg -si)
rm -rf /tmp/paru
```

Optionally enable `Color` in `/etc/pacman.conf`.

#### GRUB customization

- Use GRUB Customizer to rename and reorder entries.
- Install the [GRUB theme](https://github.com/vinceliuice/grub2-themes):
  ```bash
  git clone https://github.com/vinceliuice/grub2-themes
  cd grub2-themes
  sudo ./install.sh -t vimix -b
  ```

#### Mirrors

```bash
sudo pacman -S reflector rsync
sudo reflector --latest 50 --sort rate --save /etc/pacman.d/mirrorlist
```

#### Serial-port permissions for `espflash`

Replace the device path when necessary, then log out and back in:

```bash
sudo usermod -aG "$(stat -c '%G' /dev/ttyUSB0)" "$USER"
```

#### [Docker](https://docs.docker.com/engine/install/linux-postinstall/)

```bash
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
```

Log out and back in, then verify that Docker works without `sudo`.

#### qBittorrent

1. Enable View > Search Engine.
2. In the Search tab, select Search plugins > Check for updates.

#### Dual-boot clock

To make Linux use the local hardware clock:

```bash
timedatectl set-local-rtc 1 --adjust-system-clock
```

Ensure that Windows sets the time automatically.

### Windows fine-tuning

#### Mouse acceleration

Settings > Bluetooth & devices > Mouse > Additional mouse settings > Pointer
Options > clear **Enhance pointer precision**.

#### Display refresh rate

Right-click the desktop > Display settings > select the display > choose the
correct refresh rate.

#### League of Legends window mode

1. Set `WindowMode=2` in
   `C:\Riot Games\League of Legends\Config\game.cfg`.
2. Mark the file read-only if the game keeps resetting the value.

#### qBittorrent

1. Enable View > Search Engine.
2. In the Search tab, select Search plugins > Check for updates.

#### [PowerToys](https://github.com/microsoft/PowerToys)

Disable `Win+Space` through Keyboard Manager when it conflicts with another
shortcut.

#### NVIDIA app

Disable the performance overlay under Settings > General when it is not
needed.
