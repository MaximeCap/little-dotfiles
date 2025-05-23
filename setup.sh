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

if [ "$IGNORE_NIX" = false ]; then
  if ! check_nix_installed; then
    echo "Nix is not installed. Installing ..."

    # Detect operating system
    OS=$(uname -s)

    # Check if we're in a container
    IN_CONTAINER=false
    if [ -f "/.dockerenv" ] || [ -f "/run/.containerenv" ] || grep -q docker /proc/1/cgroup 2>/dev/null; then
      IN_CONTAINER=true
    fi

    if [ "$OS" = "Darwin" ]; then
      # macOS installation - always use multi-user install
      echo "Detected macOS - using multi-user installation"
      sh <(curl -L https://nixos.org/nix/install)
    elif [ "$IN_CONTAINER" = true ]; then
      # Container installation - always use single-user install
      echo "Detected container environment - using single-user installation"
      sh <(curl -L https://nixos.org/nix/install) --no-daemon
    else
      # Linux non-container - prefer multi-user but fallback to single-user
      echo "Detected Linux - attempting multi-user installation"
      if command -v systemctl >/dev/null 2>&1; then
        sh <(curl -L https://nixos.org/nix/install)
      else
        echo "systemd not detected - falling back to single-user installation"
        sh <(curl -L https://nixos.org/nix/install) --no-daemon
      fi
    fi

    # Source Nix environment after installation
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    elif [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
      . ~/.nix-profile/etc/profile.d/nix.sh
    fi
  fi
fi

# Function to source Nix and verify installation
source_nix_and_verify() {
  # Source Nix environment for this session
  if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    echo "Nix daemon profile found! Sourcing it"
    source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    echo "Sourced nix-daemon.sh"
  elif [ -f "$HOME"/.nix-profile/etc/profile.d/nix.sh ]; then
    echo "Nix single-user profile found! Sourcing it"
    source "$HOME"/.nix-profile/etc/profile.d/nix.sh
    echo "Sourced nix.sh"
  else
    echo "Warning: Neither Nix daemon nor single-user profile found."
    return 1
  fi

  # Add Nix to PATH explicitly as a fallback
  if [ -d "$HOME/.nix-profile/bin" ]; then
    export PATH="$HOME/.nix-profile/bin:$PATH"
    echo "Added $HOME/.nix-profile/bin to PATH"
  fi

  # Verify nix is in path
  if command -v nix >/dev/null 2>&1; then
    echo "Success: nix is now in PATH: $(which nix)"
    return 0
  else
    echo "Error: nix command still not found in PATH even after sourcing"
    return 1
  fi
}

# Source Nix and verify it works
source_nix_and_verify# Configure the home directory

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

# Install Nix packages from config.nix
if [ "$IGNORE_NIX" = false ]; then
  echo "Installing Nix packages ..."
  "$HOME"/.nix-profile/bin/nix-env -iA nixpkgs.myPackages
fi

echo "Setup complete"
