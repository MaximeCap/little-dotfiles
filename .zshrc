# My Zshrc Config

#zmodload zsh/zprof

# Cross-platform Homebrew detection
if [[ "$OSTYPE" == "darwin"* ]]; then
  if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
elif [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [ -f "$HOME"/.nix-profile/etc/profile.d/nix.sh ]; then . "$HOME"/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if env var result to an empty folder
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi

# Source and Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions - optimized to run once per day
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+4) ]]; then
  compinit
else
  compinit -C
fi

zinit cdreplay -q

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


#History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Cross-platform ls color flag
if [[ "$OSTYPE" == "darwin"* ]]; then
  LS_COLOR_FLAG="-G"
else
  LS_COLOR_FLAG="--color"
fi
zstyle ':fzf-tab:complete:cd:*' fzf-preview "ls $LS_COLOR_FLAG \$realpath"
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview "ls $LS_COLOR_FLAG \$realpath"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

export VISUAL=vi
export EDITOR=vi
export TERM=screen

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# alias
alias k="kubectl"
alias n="nvim"
# alias bvim="NVIM_APPNAME=mini-nvim nvim"

alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias cd="zd"
alias lg="lazygit"
alias ll="lsa"
alias gsw="git switch"
alias gs="git status"
alias gcm="git commit -m"

alias n11="NVIM_APPNAME=nvim11 nvim"

zd() {
  if [ $# -eq 0 ]; then
    builtin cd ~ && return
  elif [ -d "$1" ]; then
    builtin cd "$1"
  else
    z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
  fi
}

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases

# opencode - use $HOME instead of hardcoded path
[ -d "$HOME/.opencode/bin" ] && export PATH="$HOME/.opencode/bin:$PATH"

# PostgreSQL - cross-platform detection
if [[ "$OSTYPE" == "darwin"* ]]; then
  [ -d "/opt/homebrew/opt/postgresql@18/bin" ] && export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
elif [ -d "/usr/lib/postgresql/18/bin" ]; then
  export PATH="/usr/lib/postgresql/18/bin:$PATH"
fi

# bun completions - use $BUN_INSTALL
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Source local overrides
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# End timing
# unsetopt XTRACE
# exec 2>&3 3>& --async-

#zprof
export PATH="$HOME/.local/bin:$PATH"
