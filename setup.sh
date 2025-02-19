#!/bin/bash

## Useful method
check_nix_installed() {
  command -v nix >/dev/null 2>&1
}

if ! check_nix_installed; then
  echo "Nix is not installed. Installing ..."
  sh <(curl -L https://nixos.org/nix/install) --daemon

  # Source Nix environment after installation
  if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
    . ~/.nix-profile/etc/profile.d/nix.sh
  fi

  # For multi-user installations, source daemon environment
  if [ -e /etc/profile.d/nix.sh ]; then
    . /etc/profile.d/nix.sh
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

#############################################
###### Symlinking ###########################
#############################################

echo "Symlinking the configuration files ..."

# Backup the existing zshrc file
mv "$HOME"/.zshrc "$HOME"/.zshrc.bak
# Symlink the zshrc configuration file and force it if it exists
ln -s "$PWD"/.zshrc "$HOME"/.zshrc
# Symlink the nvim configuration file
ln -s "$PWD"/nvim "$XDG_CONFIG_HOME"/nvim
# Symlink the nix configuration file
ln -s "$PWD"/config.nix "$XDG_CONFIG_HOME"/nixpkgs/config.nix
# Symlink the tmux configuration file
ln -s "$PWD"/tmux.conf "$HOME"/.tmux.conf

# Install Nix packages from config.nix
echo "Installing Nix packages ..."
nix-env -iA nixpkgs.myPackages

echo "Setup complete"
