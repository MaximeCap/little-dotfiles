alias zl="zoxide query -l | fzf"

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias cd="zd"

alias gsw="git switch"
alias gs="git status"
alias gcm="git commit -m"

alias ls="eza --icons -lah --git"
alias ll="ls"
alias lt='eza --tree --level=2 --long --icons --git'
alias lg="lazygit"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

compdef eza=ls

if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
fi

alias vim=nvim

alias grep="rg --color=auto"
alias diff="diff --color=auto"
alias df="df -h"

alias glog='PAGER="less -F -X" git log'
alias galog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
