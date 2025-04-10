# My Zshrc Config

#zmodload zsh/zprof

#eval "$(/opt/homebrew/bin/brew shellenv)"
# if [ -e /home/max/.nix-profile/etc/profile.d/nix.sh ]; then . /home/max/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

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

# Add in snippets
# zinit snippet OMZP::git
# zinit snippet OMZP::sudo
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx

# Load completions
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit -C

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
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
#alias air=$(go env GOPATH)/bin/air

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/max.omp.toml)"
eval "$(fnm env --use-on-cd --shell zsh)"

[ -s "/Users/maxime.cappellen.e/.jabba/jabba.sh" ] && source "/Users/maxime.cappellen.e/.jabba/jabba.sh"

# bun completions
[ -s "/Users/maxime.cappellen.e/.bun/_bun" ] && source "/Users/maxime.cappellen.e/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/maxime.cappellen.e/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

export VISUAL=nvim
export EDITOR=nvim

export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# alias
alias k="kubectl"
alias n="nvim"
alias ll="ls -la"
alias lg="lazygit"

source ~/.zshrc.local

# End timing
# unsetopt XTRACE
# exec 2>&3 3>& --async-

# fnm
FNM_PATH="/Users/maxime.cappellen.e/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/maxime.cappellen.e/Library/Application Support/fnm:$PATH"
  eval "`fnm env`"
fi

#zprof
