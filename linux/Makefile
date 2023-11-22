.DEFAULT_GOAL := help

.PHONY: help
help:
	@ echo "Usage: make [TARGET]\n"
	@ echo "Targets:"
	@ echo "  dot                 Configures dotfiles symlinks"
	@ echo "  install-packages    Installs all the packages"
	@ echo "  remove-packages     Removes unnecessary packages installed with gnome"
	@ echo "  rust                Installs Rust and crates"
	@ echo "  udev                Configures openocd (https://docs.espressif.com/projects/esp-idf/en/release-v5.1/esp32c2/api-guides/jtag-debugging/configure-other-jtag.html) and probe-rs(https://probe.rs/docs/getting-started/probe-setup/#udev-rules) udev rules"

.PHONY: dot
dot:
	@ dot init SergioGasquez/dotfiles
	@ dot check

.PHONY: install-packages
install-packages:
	@ paru --needed -S - < packages

.PHONY: remove-packages
remove-packages:
	@ paru --noconfirm -R - < packages-to-delete

.PHONY: rust
rust:
	@ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	@ cat ../common/rust/crates | while IFS= read -r line; do read -r crate arguments <<< "$$line"; cargo install "$$crate" $$arguments; done

.PHONY: udev
udev:
	@ sudo wget -O /etc/udev/rules.d/69-probe-rs.rules https://probe.rs/files/69-probe-rs.rules
	@ sudo wget -O /etc/udev/rules.d/60-openocd.rules https://raw.githubusercontent.com/espressif/openocd-esp32/master/contrib/60-openocd.rules
	@ sudo udevadm control --reload-rules
	@ sudo udevadm trigger

