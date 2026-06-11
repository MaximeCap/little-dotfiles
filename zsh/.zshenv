# ~/.config/zsh/.zshenv

# Centralized config/cache/data locations
# export XDG_CACHE_HOME="$HOME/.cache"
# export XDG_DATA_HOME="$HOME/.local/share"
# export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Default editor used by git
export EDITOR="nvim"
export VISUAL="nvim"

# Personal binaries/scripts
export PATH="$HOME/.local/bin:$PATH"

if command -v bat >/dev/null 2>&1; then
  export MANPAGER="bat -l man -p"
fi

. "$HOME/.cargo/env"
