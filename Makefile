.PHONY: reload_shell install install_brew install_rosetta install_brew_bundle setup_env setup_node setup_os backup uninstall

.ONESHELL:
install:
	@${MAKE} install_xcode_devtools
	@${MAKE} install_brew
	@${MAKE} install_rosetta
	@${MAKE} install_brew_bundle
	@${MAKE} setup_node
	@${MAKE} setup_env
	@${MAKE} setup_os


install_xcode_devtools:
	@sh ./commands/install_xcode_devtools

install_brew:
	@sh ./commands/install_brew

install_rosetta:
	@sh ./commands/install_rosetta

install_brew_bundle:
	@sh ./commands/install_brew_bundle

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
