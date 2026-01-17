#!/bin/bash
set -e

REPO="${REPOSITORY:-}"
BRANCH="${BRANCH:-}"
TARGET="${TARGETPATH:-$HOME/.dotfiles}"
INSTALL_CMD="${INSTALLCOMMAND:-}"

if [[ -z "$REPO" ]]; then
  echo "Error: repository is required"
  exit 1
fi

# Add https://github.com/ prefix if not a full URL
if [[ ! "$REPO" =~ ^https?:// && ! "$REPO" =~ ^git@ ]]; then
  REPO="https://github.com/${REPO}.git"
fi

# Expand ~ to home directory
TARGET="${TARGET/#\~/$HOME}"

echo "[i] Cloning dotfiles from $REPO to $TARGET..."
if [[ -n "$BRANCH" ]]; then
  git clone --depth=1 --branch "$BRANCH" "$REPO" "$TARGET"
else
  git clone --depth=1 "$REPO" "$TARGET"
fi

# Run install command if specified
if [[ -n "$INSTALL_CMD" ]]; then
  echo "[i] Running install command: $INSTALL_CMD"
  cd "$TARGET"
  chmod +x "$INSTALL_CMD"
  ./"$INSTALL_CMD"
fi

echo "[i] Dotfiles installation complete!"
