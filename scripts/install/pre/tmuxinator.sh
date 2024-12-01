#!/usr/bin/env bash

# Check if tmuxinator is installed using Homebrew
if ! command -v tmuxinator &>/dev/null; then
  echo "tmuxinator is not installed. Installing it now..."
  brew install tmuxinator

  if [ $? -ne 0 ]; then
    echo "❌ Failed to install tmuxinator. Exiting..." >&2
    exit 1
  fi
fi

# installed successfully
exit 0
