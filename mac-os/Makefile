MAC_DOTFILES := $(shell pwd)
DOTFILES := $(shell cd .. && pwd)

.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Usage: make [TARGET]\n"
	@echo "Targets:"
	@echo "  git                 Configures git"
	@echo "  install-packages    Installs all the packages"
	@echo "  rust                Configures Rust aliases and installs crates"
	@echo "  shell               Configures Fish"
	@echo "  vscode              Configures VS Code settings"

.PHONY: git
git:
	@ ln -sf $(DOTFILES)/common/gitconfig $(HOME)/.gitconfig

.PHONY: install-packages
install-packages:
	@ cat packages | xargs -I {} brew install {}

.PHONY: rust
rust:
	@ touch $(HOME)/.cargo/config.toml
	@ ln -sf $(DOTFILES)/common/rust/config.toml $(HOME)/.cargo/config.toml
	@ bash -c 'while read -r crate arguments; do cargo install "$crate" $arguments; done < ../common/rust/crates

.PHONY: shell
shell:
	@ mkdir -p $(HOME)/.config/fish
	@ touch $(HOME)/.config/fish/config.fish
	@ touch $(HOME)/.config/fish/aliases.fish
	@ ln -sf $(MAC_DOTFILES)/shell/config.fish $(HOME)/.config/fish/config.fish
	@ ln -sf $(DOTFILES)/common/shell/aliases.fish $(HOME)/.config/fish/aliases.fish
	@ mkdir -p $(HOME)/.config/fish/functions
	@ ln -sf $(DOTFILES)/common/shell/fish_greeting.fish $(HOME)/.config/fish/functions/fish_greeting.fish

.PHONY: vscode
vscode:
	@ mkdir -p "$(HOME)/.config/Code/User/settings.json"
	@ ln -sf "$(DOTFILES)/common/vscode/settings.json" "$(HOME)/Library/Application Support/Code - Insiders/User/profiles/642c7b44/settings.json"
	@ ln -sf "$(DOTFILES)/common/vscode/keybindings.json" "$(HOME)/Library/Application Support/Code - Insiders/User/profiles/642c7b44/keybindings.json"
