#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if ! command -v zsh &>/dev/null; then
  if ! command -v brew &>/dev/null; then
    echo "zsh not found and Homebrew unavailable to install it. Install zsh manually and re-run."
    exit 1
  fi

  echo "zsh not found. Installing via Homebrew..."
  brew install zsh
fi

if ! command -v git &>/dev/null; then
  echo "git not found. Install git before running the installer."
  exit 1
fi

echo "zsh prerequisites satisfied."
