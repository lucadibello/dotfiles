#!/usr/bin/env bash

# Check if fish is installed using Homebrew
if ! command -v fish &>/dev/null; then
  echo "fish is not installed. Installing it now..."
  if ! brew install fish; then
    echo "❌ Failed to install fish. Exiting..." >&2
    exit 1
  fi

  # Add Homebrew to fish shell path
  if ! fish -c "fish_add_path /opt/homebrew/bin"; then
    echo "❌ Failed to add Homebrew path to fish. Exiting..." >&2
    exit 1
  fi
fi

# Check if fisher is installed using Homebrew
if ! command -v fisher &>/dev/null; then
  echo "fisher is not installed. Installing it now..."
  if ! brew install fisher; then
    echo "❌ Failed to install fisher. Exiting..." >&2
    exit 1
  fi
fi

echo "✅ All required packages have been installed successfully."
exit 0
