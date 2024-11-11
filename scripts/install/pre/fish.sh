#!/bin/bash

# Check if fish is installed using Homebrew
if ! command -v fish &>/dev/null; then
  echo "fish is not installed. Installing it now..."
  brew install fish fisher

  if [ $? -ne 0 ]; then
    echo "❌ Failed to install fisher. Exiting..." >&2
    exit 1
  fi
fi

# installed successfully
exit 0
