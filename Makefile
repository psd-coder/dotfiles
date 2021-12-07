.PHONY: install install_brew install_packages install_cask install_apps install_managers install_vscode_extensions setup_env setup_node setup_os uninstall

install:
	@${MAKE} install_xcode_devtools
	@${MAKE} install_brew
	@${MAKE} install_packages
	@${MAKE} install_cask
	@${MAKE} install_apps
	@${MAKE} install_managers
	@${MAKE} install_vscode_extensions
	@${MAKE} setup_env
	@${MAKE} setup_node
	@${MAKE} setup_os

install_xcode_devtools:
	@sh ./commands/install_xcode_devtools

install_brew:
	@sh ./commands/install_brew

install_packages:
	@sh ./commands/install_brew_packages

install_cask:
	@sh ./commands/install_casks

install_apps:
	@sh ./commands/install_apps

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

uninstall:
	@sh ./commands/uninstall
