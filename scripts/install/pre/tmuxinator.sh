#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if ! command -v brew &>/dev/null; then
  echo "ℹ️ Homebrew not found; skipping tmuxinator installation."
  exit 0
fi

# Check if tmuxinator is installed using Homebrew
if ! command -v tmuxinator &>/dev/null; then
  echo "tmuxinator is not installed. Installing it now..."
  if ! brew install tmuxinator; then
    echo "❌ Failed to install tmuxinator. Exiting..." >&2
    exit 1
  fi
fi

exit 0
