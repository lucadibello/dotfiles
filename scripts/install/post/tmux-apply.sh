#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if ! command -v tmux &>/dev/null; then
  echo "ℹ️ tmux not found; skipping reload."
  exit 0
fi

# Start a server if not started, then source config. Do not fail if no sessions exist.
tmux start-server
tmux source-file "$HOME/.tmux.conf" || true
