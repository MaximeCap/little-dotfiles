#!/bin/bash

# prerequisit
if command -v hostnamectl >/dev/null 2>&1; then
  if [ ! -f "$HOME/.local/bin/fd" ]; then
    ln -s $(which fdfind) ~/.local/bin/fd
  fi

  if [ ! -f "$HOME/.local/bin/bat" ]; then
    ln -s $(which batcat) ~/.local/bin/bat
  fi
fi

# Init create directory
if [ -d "$XDG_STATE_HOME/zsh" ]; then
  mkdir -p "$XDG_STATE_HOME/zsh"
fi

if [ -d "$XDG_CACHE_HOME/zsh" ]; then
  mkdir -p "$XDG_CACHE_HOME/zsh"
fi

