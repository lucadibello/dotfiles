#!/usr/bin/env bash

# Check if tmux plugin manager is already installed. If not, install it.
INSTALL_DIR=~/.tmux/plugins/tpm
if [ -d "$INSTALL_DIR" ]; then
  echo "Tmux Plugin Manager is already installed."
  exit 0
fi

# Install Tmux Plugin Manager from source
echo "Installing Tmux Plugin Manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [ $? -eq 0 ]; then
  echo "Tmux Plugin Manager has been installed."
  exit 0
else
  # Write to stderr
  echo "Failed to install Tmux Plugin Manager." >&2
  exit 1
fi
