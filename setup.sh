#!/bin/bash

## Useful method
check_nix_installed() {
  command -v nix >/dev/null 2>&1
}

if ! check_nix_installed; then
  echo "Nix is not installed. Installing ..."
  sh <(curl -L https://nixos.org/nix/install)

  # Source Nix environment after installation
  if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
    . ~/.nix-profile/etc/profile.d/nix.sh
  fi
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
# Create the oh-my-posh folder
mkdir -p "$XDG_CONFIG_HOME"/oh-my-posh

#############################################
###### Symlinking ###########################
#############################################

echo "Symlinking the configuration files ..."

# Backup the existing zshrc file if it exists
[ -f "$HOME"/.zshrc ] && mv "$HOME"/.zshrc "$HOME"/.zshrc.bak
# Symlink the zshrc configuration file and force it if it exists
ln -sf "$PWD"/.zshrc "$HOME"/.zshrc
# Symlink the nvim configuration file
ln -sf "$PWD"/nvim "$XDG_CONFIG_HOME"/nvim
# Symlink the nix configuration file
ln -sf "$PWD"/config.nix "$XDG_CONFIG_HOME"/nixpkgs/config.nix
# Symlink the tmux configuration file
ln -sf "$PWD"/tmux.conf "$HOME"/.tmux.conf
# Symlink the oh-my-posh configuration file
ln -sf "$PWD"/max-omp.toml "$XDG_CONFIG_HOME"/ohmyposh/max-omp.toml

# Install Nix packages from config.nix
echo "Installing Nix packages ..."
nix-env -iA nixpkgs.myPackages

echo "Setup complete ! Starting zsh"
zsh
