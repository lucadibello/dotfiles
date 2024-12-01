#!/usr/bin/env bash

# Check if fish is installed using Homebrew
if ! command -v fish &>/dev/null; then
  echo "fish is not installed. Installing it now..."
  brew install fish

  # Add homebrew to fish shell
  fish -c "fish_add_path /opt/homebrew/bin"

  if [ $? -ne 0 ]; then
    echo "❌ Failed to install fish. Exiting..." >&2
    exit 1
  fi
fi

# Check if fish is installed using Homebrew
if ! command -v fisher &>/dev/null; then
  echo "fisher is not installed. Installing it now..."
  brew install fisher

  if [ $? -ne 0 ]; then
    echo "❌ Failed to install fisher. Exiting..." >&2
    exit 1
  fi
fi

# installed successfully
exit 0
