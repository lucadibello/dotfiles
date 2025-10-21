#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if command -v chezmoi &>/dev/null; then
  echo "chezmoi already installed."
  exit 0
fi

if ! command -v brew &>/dev/null; then
  echo "chezmoi not found and Homebrew unavailable to install it. Install chezmoi manually and re-run."
  exit 1
fi

echo "Installing chezmoi with Homebrew..."
brew install chezmoi
echo "chezmoi installed."
