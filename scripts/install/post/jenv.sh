#!/usr/bin/env bash

# download jenv.fish script from official page + link it

if ! command -v fish &>/dev/null; then
  echo "fish not available; skipping fish-specific jenv integration."
  exit 0
fi

curl --create-dirs -O --output-dir ~/.config/fish/functions https://raw.githubusercontent.com/jenv/jenv/refs/heads/master/fish/jenv.fish
