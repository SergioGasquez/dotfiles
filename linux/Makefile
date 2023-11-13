LINUX_DOTFILES := $(shell pwd)
DOTFILES := $(shell cd .. && pwd)

.DEFAULT_GOAL := help

.PHONY: help
help:
	@ echo -e "Usage: \tmake [TARGET]\n"
	@ echo -e "Targets:"
	@ echo -e "  git			    	  Configures git"
	@ echo -e "  install-packages    	  Installs all the packages"
	@ echo -e "  network			      Configures Google DNS"
	@ echo -e "  remove-packages    	  Removes unnecesary packages installed with gnome"
	@ echo -e "  rust    	  			  Configures Rust aliases and installs crates"
	@ echo -e "  shell    	  			  Configures Fish"
	@ echo -e "  terminal    	  		  Configures Alacritty"
	@ echo -e "  vscode    	  			  Configures VS Code settings"

.PHONY: git
git:
	@ ln -sf $(DOTFILES)/common/gitconfig $(HOME)/.gitconfig

.PHONY: install-packages
install-packages:
	@ paru --needed -S - < packages

.PHONY: network
network:
	@ ln -sf $(LINUX_DOTFILES)/resolved.conf /etc/resolved.conf

.PHONY: bluetooth
network:
	@ systemctl start bluetooth.service
	@ systemctl enable bluetooth.service

.PHONY: remove-packages
remove-packages:
	@ paru --noconfirm -R - < packages-to-delete

.PHONY: rust
rust:
	@ touch $(HOME)/.cargo/config.toml
	@ ln -sf $(DOTFILES)/common/rust/config.toml $(HOME)/.cargo/config.toml
	@ cat ../common/rust/crates | xargs -I {} cargo install {}

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
