.PHONY: reload_shell install install_brew install_rosetta install_brew_bundle install_managers install_vscode_extensions setup_env setup_node setup_os backup uninstall

.ONESHELL:
install:
	@${MAKE} install_xcode_devtools
	@${MAKE} install_brew
	@${MAKE} install_rosetta
	@${MAKE} install_brew_bundle
	@${MAKE} install_managers
	@${MAKE} install_vscode_extensions
	@${MAKE} setup_env
	@${MAKE} setup_node
	@${MAKE} setup_os


install_xcode_devtools:
	@sh ./commands/install_xcode_devtools

install_brew:
	@sh ./commands/install_brew

install_rosetta:
	@sh ./commands/install_rosetta

install_brew_bundle:
	@sh ./commands/install_brew_bundle

install_managers:
	@sh ./commands/install_managers

install_vscode_extensions:
	@sh ./commands/install_vscode_extensions

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
