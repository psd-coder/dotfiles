# macOS-specific exports

# Homebrew - hardcode prefix to avoid slow $(brew --prefix) calls
export HOMEBREW_PREFIX="/opt/homebrew"
if [[ -x "$HOMEBREW_PREFIX/bin/brew" ]]; then
  export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
  export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
  path_prepend "$HOMEBREW_PREFIX/bin"
  path_prepend "$HOMEBREW_PREFIX/sbin"
  export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:"
  export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"
fi

# 1Password SSH Agent
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# macOS colors
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# pnpm - hardcode path instead of $(pnpm global bin)
export PNPM_HOME="$HOME/Library/pnpm"
path_prepend "$PNPM_HOME"

# Homebrew-dependent paths (using cached HOMEBREW_PREFIX)
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  # LLVM
  if [[ -d "$HOMEBREW_PREFIX/opt/llvm@20" ]]; then
    export LLVM_CONFIG="$HOMEBREW_PREFIX/opt/llvm@20/bin/llvm-config"
    export LDFLAGS="-L/$HOMEBREW_PREFIX/opt/llvm@20/lib"
    export CPPFLAGS="-I/$HOMEBREW_PREFIX/opt/llvm@20/include"
    export CMAKE_PREFIX_PATH="$HOMEBREW_PREFIX/opt/llvm@20"
    path_prepend "$HOMEBREW_PREFIX/opt/llvm@20/bin"
  fi

  # GNU tools and other brew packages
  path_prepend "$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin"
  path_prepend "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
  path_prepend "$HOMEBREW_PREFIX/opt/ruby/bin"
  path_prepend "$HOMEBREW_PREFIX/opt/crowdin@3/bin"
fi
