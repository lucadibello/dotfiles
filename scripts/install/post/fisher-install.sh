#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# Require fish to proceed
if ! command -v fish &>/dev/null; then
  echo "ℹ️ fish not found; skipping fisher plugin setup."
  exit 0
fi

# Ensure fisher is available inside fish
if ! fish -c "type -q fisher"; then
  echo "ℹ️ fisher not found in fish; skipping plugin setup."
  exit 0
fi

# Install + configure tide
fish -c "fisher install IlanCosman/tide@v6"
fish -c "tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time=No --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No"

# Install plugins
fish -c "fisher install jorgebucaran/autopair.fish"
fish -c "fisher install franciscolourenco/done"
fish -c "fisher install PatrickF1/fzf.fish"
fish -c "fisher install jhillyerd/plugin-git"

# (Dependencies for fzf.fish: fd, bat)
if command -v brew &>/dev/null; then
  brew install fd bat
else
  echo "ℹ️ Homebrew not found; skipping fd and bat installation."
fi
