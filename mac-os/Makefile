.DEFAULT_GOAL := help

.PHONY: help
help:
	@ echo "Usage: make [TARGET]\n"
	@ echo "Targets:"
	@ echo "  dot                 Configures dotfiles symlinks"
	@ echo "  install-packages    Installs all the packages"
	@ echo "  rust                Installs Rust and crates"

.PHONY: dot
dot:
	@ dot init SergioGasquez/dotfiles
	@ dot check

.PHONY: install-packages
install-packages:
	@ cat packages | xargs -I {} brew install {}

.PHONY: rust
rust:
	@ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	@ cat ../common/rust/crates | while IFS= read -r line; do read -r crate arguments <<< "$$line"; cargo install "$$crate" $$arguments; done

