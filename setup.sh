#!/bin/bash

## Useful method
check_nix_installed() {
  command -v nix >/dev/nulk 2>&1
}

if ! check_nix_installed; then
  echo "Nix is not installed. Installing ..."
  sh <(curl -L https://nixos.org/nix/install)
fi

# Configure the home directory
export XDG_CONFIG_HOME="$HOME"/.config

#############################################
###### Folder Creation ######################
#############################################

echo "Creating the necessary folders ..."

# Create the folder if not exist
mkdir -p "$XDG_CONFIG_HOME"
# Create the folder for nixpkgs
mkdir -p "$XDG_CONFIG_HOME"/nixpkgs

#############################################
###### Symlinking ###########################
#############################################

echo "Symlinking the configuration files ..."

# Symlink the zshrc configuration file
ln -s "$PWD"/.zshrc "$HOME"/.zshrc
# Symlink the nvim configuration file
ln -s "$PWD"/nvim "$XDG_CONFIG_HOME"/nvim
# Symlink the nix configuration file
ln -s "$PWD"/config.nix "$XDG_CONFIG_HOME"/nixpkgs/config.nix
# Symlink the tmux configuration file
ln -s "$PWD"/tmux.conf "$HOME"/.tmux.conf

# Reload zsh
source "$HOME"/.zshrc

# Install Nix packages from config.nix
nix-env -iA nixpkgs.myPackages
