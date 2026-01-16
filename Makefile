.PHONY: install install_macos install_linux install_xcode_devtools install_brew install_brew_bundle install_apt setup_env setup_node setup_os backup uninstall

UNAME := $(shell uname -s)

.ONESHELL:

# Main install target - detects OS and runs appropriate targets
install:
ifeq ($(UNAME),Darwin)
	@${MAKE} install_macos
else
	@${MAKE} install_linux
endif

# macOS installation flow
install_macos:
	@${MAKE} install_xcode_devtools
	@${MAKE} install_brew
	@${MAKE} install_brew_bundle
	@${MAKE} setup_node
	@${MAKE} setup_env
	@${MAKE} setup_os
	@echo "\n✓ Installation complete! Open a new terminal to use your dotfiles."

# Linux installation flow
install_linux:
	@${MAKE} install_apt
	@${MAKE} setup_node
	@${MAKE} setup_env
	@echo "\n✓ Installation complete! Open a new terminal to use your dotfiles."

install_xcode_devtools:
	@./commands/install_xcode_devtools

install_brew:
	@./commands/install_brew

install_brew_bundle:
	@./commands/install_brew_bundle

install_apt:
	@./commands/install_apt

setup_env:
	@./commands/setup_env

setup_node:
	@./commands/setup_node

setup_os:
	@./commands/setup_os

backup:
	@./commands/backup

uninstall:
	@./commands/uninstall
