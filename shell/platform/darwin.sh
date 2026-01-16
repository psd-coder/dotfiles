# macOS-specific exports

# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

# 1Password SSH Agent
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# macOS colors
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
path_prepend "$PNPM_HOME"

# Homebrew-dependent paths and configs
if command -v brew &> /dev/null; then
  BREW_PREFIX="$(brew --prefix)"

  # LLVM
  if [[ -d "$BREW_PREFIX/opt/llvm@20" ]]; then
    export LLVM_CONFIG="$BREW_PREFIX/opt/llvm@20/bin/llvm-config"
    export LDFLAGS="-L/$BREW_PREFIX/opt/llvm@20/lib"
    export CPPFLAGS="-I/$BREW_PREFIX/opt/llvm@20/include"
    export CMAKE_PREFIX_PATH="$BREW_PREFIX/opt/llvm@20"
    path_prepend "$BREW_PREFIX/opt/llvm@20/bin"
  fi

  # GNU tools and other brew packages
  path_prepend "$BREW_PREFIX/opt/findutils/libexec/gnubin"
  path_prepend "$BREW_PREFIX/opt/coreutils/libexec/gnubin"
  path_prepend "$BREW_PREFIX/opt/ruby/bin"
  path_prepend "$BREW_PREFIX/opt/crowdin@3/bin"
fi
