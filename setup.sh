#!/bin/bash

# Parse command-line arguments
IGNORE_NIX=false
for arg in "$@"; do
  case $arg in
  --nix-ignore)
    IGNORE_NIX=true
    shift
    ;;
  *)
    shift
    ;;
  esac
done

## Useful method
check_nix_installed() {
  command -v nix >/dev/null 2>&1
}

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
mkdir -p "$XDG_CONFIG_HOME"/ohmyposh
# Create the zellij folder
mkdir -p "$XDG_CONFIG_HOME"/zellij

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
# Symlink the nix configuration file
ln -sf "$PWD"/config.nix "$XDG_CONFIG_HOME"/nixpkgs/config.nix
# Symlink the tmux configuration file
ln -sf "$PWD"/tmux.conf "$HOME"/.tmux.conf
# Symlink the oh-my-posh configuration file
ln -sf "$PWD"/max.omp.toml "$XDG_CONFIG_HOME"/ohmyposh/max.omp.toml
# Symlink the zellij configuration file
ln -sf "$PWD"/config.kdl "$XDG_CONFIG_HOME"/zellij/config.kdl

if [ "$IGNORE_NIX" = false ]; then
  if ! check_nix_installed; then
    echo "Nix is not installed. Installing ..."
    sh <(curl -L https://nixos.org/nix/install)
    #
    # Source Nix environment after installation
    if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
      . ~/.nix-profile/etc/profile.d/nix.sh
    fi
  fi
fi
# Source Nix environment after installation
if [ -f "$HOME"/.nix-profile/etc/profile.d/nix.sh ]; then
  echo "Nix profile found ! Sourcing it"
  source "$HOME"/.nix-profile/etc/profile.d/nix.sh
  echo "Sourced"
fi

# Install Nix packages from config.nix
if [ "$IGNORE_NIX" = false ]; then
  echo "Installing Nix packages ..."
  "$HOME"/.nix-profile/bin/nix-env -iA nixpkgs.myPackages
fi

echo "Setup complete"
