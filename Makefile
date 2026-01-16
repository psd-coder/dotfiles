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

# Linux installation flow
install_linux:
	@${MAKE} install_apt
	@${MAKE} setup_node
	@${MAKE} setup_env

install_xcode_devtools:
	@sh ./commands/install_xcode_devtools

install_brew:
	@sh ./commands/install_brew

install_brew_bundle:
	@sh ./commands/install_brew_bundle

install_apt:
	@sh ./commands/install_apt

setup_env:
	@sh ./commands/setup_env

setup_node:
	@sh ./commands/setup_node

setup_os:
	@sh ./commands/setup_os

backup:
	@sh ./commands/backup

uninstall:
	@sh ./commands/uninstall
