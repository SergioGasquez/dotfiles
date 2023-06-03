DOTFILES := $(shell pwd)

.DEFAULT_GOAL := help

.PHONY: help
help:
	@ echo -e "Usage: \tmake [TARGET]\n"
	@ echo -e "Targets:"
	@ echo -e "  git			    	  Configures git"
	@ echo -e "  install-packages    	  Installs all the packages"
	@ echo -e "  network			      Configures Google DNS"
	@ echo -e "  remove-packages    	  Removes unnecesary packages installed with gnome"
	@ echo -e "  rust    	  			  Configures Rust aliases"
	@ echo -e "  shell    	  			  Configures Fish"
	@ echo -e "  terminal    	  		  Configures Alacritty"

.PHONY: git
git:
	@ ln -sf $(DOTFILES)/../common/gitconfig $(HOME)/.gitconfig

.PHONY: install-packages
install-packages:
	@ yay --needed -S - < packages

.PHONY: network
network:
	@ ln -sf $(DOTFILES)/resolved.conf /etc/resolved.conf

.PHONY: remove-packages
remove-packages:
	@ yay --noconfirm -R - < pacakages-to-delete

.PHONY: rust
rust:
	@ touch $(HOME)/.cargo/config.toml
	@ ln -sf $(DOTFILES)/../common/rust/config.toml $(HOME)/.cargo/config.toml

.PHONY: shell
shell:
	@ mkdir -p $(HOME)/.config/fish
	@ touch $(HOME)/.config/fish/config.fish
	@ ln -sf $(DOTFILES)/shell/config.fish $(HOME)/.config/fish/config.fish
	@ mkdir -p $(HOME)/.config/fish/functions
	@ ln -sf $(DOTFILES)/shell/fish_greeting.fish $(HOME)/.config/fish/functions/fish_greeting.fish

.PHONY: terminal
terminal:
	@ mkdir -p "$(HOME)/.config/alacritty"
	@ ln -sf $(DOTFILES)/alacritty.yml $(HOME)/.config/alacritty/alacritty.yml
