LINUX_DOTFILES := $(shell pwd)
DOTFILES := $(shell cd .. && pwd)

.DEFAULT_GOAL := help

.PHONY: help
help:
	@ echo "Usage: make [TARGET]\n"
	@ echo "Targets:"
	@ echo "  git                 Configures git"
	@ echo "  install-packages    Installs all the packages"
	@ echo "  network             Configures Google DNS"
	@ echo "  probe-rs            Configures probe-rs udev rules (https://probe.rs/docs/getting-started/probe-setup/#udev-rules)"
	@ echo "  remove-packages     Removes unnecessary packages installed with gnome"
	@ echo "  rust                Configures Rust aliases and installs crates"
	@ echo "  shell               Configures Fish"
	@ echo "  terminal            Configures Alacritty"
	@ echo "  vscode              Configures VS Code settings"


.PHONY: git
git:
	@ ln -sf $(DOTFILES)/common/gitconfig $(HOME)/.gitconfig

.PHONY: install-packages
install-packages:
	@ paru --needed -S - < packages

.PHONY: network
network:
	@ ln -sf $(LINUX_DOTFILES)/resolved.conf /etc/resolved.conf

.PHONY: probe-rs
vscode:
	@ sudo wget -O /etc/udev/rules.d/69-probe-rs.rules https://probe.rs/files/69-probe-rs.rules
	@ sudo udevadm control --reload-rules
	@ sudo udevadm trigger

.PHONY: remove-packages
remove-packages:
	@ paru --noconfirm -R - < packages-to-delete

.PHONY: rust
rust:
	@ touch $(HOME)/.cargo/config.toml
	@ ln -sf $(DOTFILES)/common/rust/config.toml $(HOME)/.cargo/config.toml
	@ bash -c 'while read -r crate arguments; do cargo install "$crate" $arguments; done < ../common/rust/crates

.PHONY: shell
shell:
	@ mkdir -p $(HOME)/.config/fish
	@ ln -sf $(DOTFILES)/common/shell/aliases.fish $(HOME)/.config/fish/aliases.fish
	@ ln -sf $(DOTFILES)/common/shell/config.fish $(HOME)/.config/fish/config.fish
	@ mkdir -p $(HOME)/.config/fish/functions
	@ ln $(DOTFILES)/common/shell/fish_greeting.fish $(HOME)/.config/fish/functions/fish_greeting.fish

.PHONY: terminal
terminal:
	@ mkdir -p "$(HOME)/.config/alacritty"
	@ ln -sf $(LINUX_DOTFILES)/alacritty.yml $(HOME)/.config/alacritty/alacritty.yml

.PHONY: vscode
vscode:
	@ mkdir -p "$(HOME)/.config/Code/User/"
	@ ln -sf "$(DOTFILES)/common/vscode/settings.json" "$(HOME)/.config/Code/User/settings.json"
	@ ln -sf "$(DOTFILES)/common/vscode/keybindings.json" "$(HOME)/.config/Code/User/keybindings.json"

