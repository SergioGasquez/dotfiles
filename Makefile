DOTFILES := $(shell pwd)

.DEFAULT_GOAL := help

.PHONY: help
help:
	@ echo -e "Usage: \tmake [TARGET]\n"
	@ echo -e "Targets:"
	@ echo -e "  shell    	  			  Configures Fish"
	@ echo -e "  code    	  			  Configures VsCode settings and keybindings"
	@ echo -e "  terminal    	  		  Configures Alacritty"
	@ echo -e "  git			    	  Configures git"
	@ echo -e "  dark-theme			      Configures dark theme"
	@ echo -e "  install-packages    	  Installs all the packages"
	@ echo -e "  remove-packages    	  Removes unnecesary packages installed with gnome"
	@ echo -e "  network			      Configures Google DNS"


.PHONY: shell
shell:
	@ mkdir -p $(HOME)/.config/fish
	@ touch $(HOME)/.config/fish/config.fish
	@ ln -sf $(DOTFILES)/shell/config.fish $(HOME)/.config/fish/config.fish
	@ mkdir -p $(HOME)/.config/fish/functions
	@ ln -sf $(DOTFILES)/shell/fish_greeting.fish $(HOME)/.config/fish/functions/fish_greeting.fish

.PHONY: code
code:
	@ mkdir -p "$(HOME)/.config/Code/User/"
#	@ ln -sf $(DOTFILES)/vscode/settings.json "$(HOME)/.config/Code/User/settings.json"
	@ ln -sf $(DOTFILES)/vscode/keybindings.json "$(HOME)/.config/Code/User/keybindings.json"

.PHONY: terminal
terminal:
	@ mkdir -p "$(HOME)/.config/alacritty"
	@ ln -sf $(DOTFILES)/alacritty.yml $(HOME)/.config/alacritty/alacritty.yml

.PHONY: git
git:
	@ ln -sf $(DOTFILES)/gitconfig $(HOME)/.gitconfig

.PHONY: install-packages
install-packages:
	@ yay --needed --noconfirm -S - < packages

.PHONY: remove-packages
remove-packages:
	@ yay --noconfirm -R - < pacakages-to-delete

.PHONY: gnome
gnome:
	@ gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

.PHONY: network
network:
	@ ln -sf $(DOTFILES)/resolved.conf /etc/resolved.conf