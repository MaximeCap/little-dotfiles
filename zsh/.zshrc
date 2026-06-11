export ZDOTDIR="$HOME/.config/zsh"

# History

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

# Smart Directory
eval "$(zoxide init zsh)"

# Completion
fpath=("${XDG_DATA_HOME:-$HOME/.local/share}/zsh/completions" $fpath)
source "$ZDOTDIR/completions.zsh"
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ':completion:*' menu select

# Case insitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ========================================================
# Fuzzy finder
# =========================================================

# macOS / Homebrew (Apple Silicon)
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# Arch
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# Ubuntu
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# fzf configuration
source "$ZDOTDIR/fzf.zsh"

# Aliases
source "$ZDOTDIR/aliases.zsh"

# Custom keybindings
source "$ZDOTDIR/bindings.zsh"

# Plugins and plugin manager
source "$ZDOTDIR/plugins.zsh"

# Prompt/theme
source "$ZDOTDIR/prompt.zsh"

if [ -f "$ZDOTDIR/.zshrc-local.zsh" ]; then
	source "$ZDOTDIR/.zshrc-local.zsh"
fi

eval "$(starship init zsh)"
