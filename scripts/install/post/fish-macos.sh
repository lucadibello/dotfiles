#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# Run only on macOS
if [ "$(uname -s)" != "Darwin" ]; then
  echo "ℹ️ Not macOS; skipping default shell change."
  exit 0
fi

FISH_BIN="/opt/homebrew/bin/fish"

if [ ! -x "$FISH_BIN" ]; then
  echo "ℹ️ $FISH_BIN not found; skipping default shell change."
  exit 0
fi

# Check if the default shell is already Fish
if [ "${SHELL:-}" = "$FISH_BIN" ]; then
  echo "Fish is already the default shell."
  exit 0
fi

# Set Fish shell as the default shell
echo "Setting Fish as the default shell..."
if ! grep -q "^${FISH_BIN}$" /etc/shells; then
  echo "Adding Fish to /etc/shells..."
  echo "$FISH_BIN" | sudo tee -a /etc/shells >/dev/null
fi

export SHELL="$FISH_BIN"
chsh -s "$FISH_BIN"
echo "Fish has been set as the default shell. Restart your terminal for the change to take effect."
