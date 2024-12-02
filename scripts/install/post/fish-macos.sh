#!/usr/bin/env bash

# Check if the default shell is already Fish
if [ "$SHELL" = "/opt/homebrew/bin/fish" ]; then
  echo "Fish is already the default shell."
  exit 0
fi

# Set Fish shell as the default shell
echo "Setting Fish as the default shell..."
if ! grep -q "^/opt/homebrew/bin/fish$" /etc/shells; then
  echo "Adding Fish to /etc/shells..."
  echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
fi

export SHELL=/opt/homebrew/bin/fish
chsh -s /opt/homebrew/bin/fish
echo "Fish has been set as the default shell. Restart your terminal for the change to take effect."
