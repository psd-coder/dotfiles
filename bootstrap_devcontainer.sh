#!/bin/bash
set -e

# Get the directory where this script is located (the cloned dotfiles repo)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$SCRIPT_DIR}"

# Use sudo only if not root
SUDO=""
if [[ "$(id -u)" -ne 0 ]]; then
  SUDO="sudo"
fi

# Install minimal dependencies
if command -v apt &> /dev/null; then
  echo "[i] Installing minimal apt packages..."
  $SUDO apt update
  $SUDO apt install -y zsh git curl vim fzf ripgrep jq
fi

# Install antidote on Linux
if [[ ! -d "$HOME/.antidote" ]]; then
  echo "[i] Installing antidote..."
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$HOME/.antidote"
fi

# Install starship prompt
if ! command -v starship &> /dev/null; then
  echo "[i] Installing starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# Install mise (version manager)
if ! command -v mise &> /dev/null; then
  echo "[i] Installing mise..."
  curl https://mise.run | sh
fi

# Run minimal setup
echo "[i] Setting up dotfiles..."
cd "$DOTFILES_DIR"
export DOTFILES_MINIMAL=1
source commands/helpers
setup_env() {
  link "$DOTFILES_SHELL/functions" "$HOME/.functions.sh"
  link "$DOTFILES_SHELL/exports" "$HOME/.exports.sh"
  link "$DOTFILES_SHELL/antidote_zsh_plugins" "$HOME/.zsh_plugins.txt"
  link "$DOTFILES_SHELL/node" "$HOME/.node.sh"
  link "$DOTFILES_SHELL/aliases" "$HOME/.aliases.sh"
  link "$DOTFILES_SHELL/antidote" "$HOME/.antidote.sh"
  link "$DOTFILES_SHELL/zshrc" "$HOME/.zshrc"
  create_dir_if_not_exists "$HOME/.config"
  link "$DOTFILES_SHELL/starship.toml" "$HOME/.config/starship.toml"
  link "$DOTFILES_SHELL/gitconfig" "$HOME/.gitconfig"
  link "$DOTFILES_SHELL/gitignore" "$HOME/.gitignore"
}
setup_env

# Change default shell to zsh (usually doesn't work in containers)
if [[ "$SHELL" != *"zsh"* ]]; then
  echo "[i] Attempting to change default shell to zsh..."
  $SUDO chsh -s "$(which zsh)" "$(whoami)" 2>/dev/null || true
fi

echo "[i] Devcontainer bootstrap complete!"
echo "[i] Restart your shell or run: exec zsh -l"
