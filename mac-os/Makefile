DOTFILES := $(shell pwd)

.DEFAULT_GOAL := help

.PHONY: help
help:
	@ echo -e "Usage: \tmake [TARGET]\n"
	@ echo -e "Targets:"
	@ echo -e "  git			    	  Configures git"
	@ echo -e "  install-packages    	  Installs all the packages"
	@ echo -e "  rust    	  			  Configures Rust aliases and installs crates"
	@ echo -e "  shell    	  			  Configures Fish"
	@ echo -e "  vscode    	  			  Configures VS Code settings"

.PHONY: git
git:
	@ ln -sf $(DOTFILES)/../common/gitconfig $(HOME)/.gitconfig

.PHONY: install-packages
install-packages:
	@ brew install < packages
	@ brew install --cask < packages-casks

.PHONY: rust
rust:
	@ touch $(HOME)/.cargo/config.toml
	@ ln -sf $(DOTFILES)/../common/rust/config.toml $(HOME)/.cargo/config.toml
	@ cat ../common/rust/crates | xargs -I {} cargo install {}

.PHONY: shell
shell:
	@ mkdir -p $(HOME)/.config/fish
	@ touch $(HOME)/.config/fish/config.fish
	@ ln -sf $(DOTFILES)/shell/config.fish $(HOME)/.config/fish/config.fish
	@ mkdir -p $(HOME)/.config/fish/functions
	@ ln -sf $(DOTFILES)/shell/fish_greeting.fish $(HOME)/.config/fish/functions/fish_greeting.fish

.PHONY: vscode
vscode:
	@ mkdir -p "$(HOME)/.config/Code/User/settings.json"
	@ ln -sf $(DOTFILES)/vscode/settings.json $(HOME)/.config/Code/User/settings.json
