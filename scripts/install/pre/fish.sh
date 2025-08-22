#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# Require Homebrew for package installs
if ! command -v brew &>/dev/null; then
  echo "❌ Homebrew not found. Please install Homebrew and re-run."
  echo "   https://brew.sh"
  exit 1
fi

# Check if fish is installed using Homebrew
if ! command -v fish &>/dev/null; then
  echo "fish is not installed. Installing it now..."
  if ! brew install fish; then
    echo "❌ Failed to install fish. Exiting..." >&2
    exit 1
  fi

  # Add Homebrew to fish shell path (Apple Silicon path)
  if ! fish -c "fish_add_path /opt/homebrew/bin"; then
    echo "❌ Failed to add Homebrew path to fish. Exiting..." >&2
    exit 1
  fi
fi

# Check if fisher is installed using Homebrew (provides a 'fisher' executable)
if ! command -v fisher &>/dev/null; then
  echo "fisher is not installed. Installing it now..."
  if ! brew install fisher; then
    echo "❌ Failed to install fisher. Exiting..." >&2
    exit 1
  fi
fi

echo "✅ fish and fisher are installed."
exit 0
