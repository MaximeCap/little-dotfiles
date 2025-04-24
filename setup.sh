#!/bin/bash

## Useful method
check_brew_installed() {
  command -v brew >/dev/null 2>&1
}

if ! check_brew_installed; then
  echo "Brew is not installed. Installing ..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Configure the home directory
export XDG_CONFIG_HOME="$HOME"/.config

#############################################
###### Folder Creation ######################
#############################################

echo "Creating the necessary folders ..."

# Create the folder if not exist
mkdir -p "$XDG_CONFIG_HOME"
# Create the oh-my-posh folder
mkdir -p "$XDG_CONFIG_HOME"/ohmyposh

# Create the folder for zsh completion
mkdir -p "$XDG_CONFIG_HOME"/.zsh/completions

# Create local .zshrc.local for fine tunning
[ -f "$HOME"/.zshrc.local ] || touch $HOME/.zshrc.local

#############################################
###### Symlinking ###########################
#############################################

echo "Symlinking the configuration files ..."

# Create the .zshrc-local if not present
[ -f "$HOME"/.zshrc.local ] || touch $HOME/.zshrc.local
# Backup the existing zshrc file if it exists
[ -f "$HOME"/.zshrc ] && mv "$HOME"/.zshrc "$HOME"/.zshrc.bak
# Symlink the zshrc configuration file and force it if it exists
ln -sf "$PWD"/.zshrc "$HOME"/.zshrc
# Symlink the nvim configuration file
ln -sf "$PWD"/nvim "$XDG_CONFIG_HOME"/nvim
# Symlink the tmux configuration file
ln -sf "$PWD"/tmux.conf "$HOME"/.tmux.conf
# Symlink the oh-my-posh configuration file
ln -sf "$PWD"/max.omp.toml "$XDG_CONFIG_HOME"/ohmyposh/max.omp.toml

brew bundle --file=Brewfile

echo "Setup complete"
