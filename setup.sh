#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config

# Installing
echo "Installing..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

OS=$(uname -s)
BREW_SHELL_ENV=""
if [ "$OS" = "Darwin" ]; then
	BREW_SHELL_ENV="/opt/homebrew/bin/brew"
else
	BREW_SHELL_ENV="/home/linuxbrew/.linuxbrew/bin/brew"
fi
echo "eval \"\$($BREW_SHELL_ENV shellenv)\"" >> "$HOME/.bashrc"
eval "$($BREW_SHELL_ENV shellenv)"

brew bundle check || brew bundle install

# Create folder if not exist
echo "Creating necessary folders"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME/nvim"

# Create local .zshrc.local for fine tunning
[ -f "$HOME"/.zshrc.local ] || touch $HOME/.zshrc.local

echo "Symlinking the configuration files ..."

# Create the .zshrc-local if not present
[ -f "$HOME"/.zshrc.local ] || touch $HOME/.zshrc.local
# Backup the existing zshrc file if it exists
[ -f "$HOME"/.zshrc ] && mv "$HOME"/.zshrc "$HOME"/.zshrc.bak

ln -sf "$PWD/bash/"* "$HOME/.local/share/omarchy"

ln -sf "$PWD"/.zshrc "$HOME"/.zshrc
ln -sf "$PWD"/tmux.conf "$HOME"/.tmux.conf
ln -sf "$PWD/nvim/"* "$XDG_CONFIG_HOME/nvim"
ln -sf "$PWD/starship.toml" "$XDG_CONFIG_HOME/starship.toml"

echo "Setup complete"

echo "source ~/.local/share/omarchy/rc" >> "$HOME/.bashrc"

