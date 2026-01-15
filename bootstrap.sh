#!/bin/bash
set -e

# Bootstrap script for fresh systems
# Usage: curl -fsSL https://raw.githubusercontent.com/psd-coder/dotfiles/master/bootstrap.sh | bash

DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/psd-coder/dotfiles.git"

echo "[i] Detecting OS..."

if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "[i] macOS detected"

  if ! xcode-select -p &> /dev/null; then
    echo "[i] Installing Xcode CLI tools..."
    xcode-select --install
    echo "[i] Waiting for Xcode CLI tools installation (click Install in the dialog)..."
    until xcode-select -p &> /dev/null; do
      sleep 5
    done
    echo "[i] Xcode CLI tools installed"
  fi

else
  echo "[i] Linux detected"

  echo "[i] Installing prerequisites..."
  sudo apt update
  sudo apt install -y git make zsh curl
fi

if [[ -d "$DOTFILES_DIR" ]]; then
  echo "[i] Dotfiles already cloned, pulling latest..."
  git -C "$DOTFILES_DIR" pull
else
  echo "[i] Cloning dotfiles..."
  git clone --branch devcontainer --single-branch --depth 1 "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

echo "[i] Running install..."
cd "$DOTFILES_DIR"

if [[ "${DOTFILES_MINIMAL:-false}" == "true" ]]; then
  DOTFILES_MINIMAL=true make install
else
  make install
fi

echo "[i] Done!"
