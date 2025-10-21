#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# Resolve repo root regardless of where this script is called from
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Useful paths (absolute)
PRE_SCRIPTS_DIR="$REPO_ROOT/scripts/install/pre"
POST_SCRIPTS_DIR="$REPO_ROOT/scripts/install/post"

run_script() {
  local script="$1"
  echo "Running $script..."
  bash "$script"
  if [ $? -ne 0 ]; then
    echo "$script failed. Check the logs for more information."
    exit 1
  fi
}

# Execute all scripts in the pre-scripts directory
echo "Running pre-scripts..."
if [ -d "$PRE_SCRIPTS_DIR" ] && [ -n "$(ls -A "$PRE_SCRIPTS_DIR" 2>/dev/null)" ]; then
  for script in "$PRE_SCRIPTS_DIR"/*.sh; do
    run_script "$script"
  done
else
  echo "No pre-scripts found in ${PRE_SCRIPTS_DIR}. Skipping pre-scripts."
fi

# Apply dotfiles with chezmoi
CHEZMOI_BIN="$(command -v chezmoi || true)"
if [ -z "$CHEZMOI_BIN" ]; then
  echo "chezmoi was not found on PATH. Ensure scripts/install/pre/chezmoi.sh ran successfully."
  exit 1
fi

echo "Applying dotfiles with chezmoi..."
"$CHEZMOI_BIN" --source="$REPO_ROOT" --destination="$HOME" apply

# Execute all scripts in the post-scripts directory
echo "Running post-scripts..."
if [ -d "$POST_SCRIPTS_DIR" ] && [ -n "$(ls -A "$POST_SCRIPTS_DIR" 2>/dev/null)" ]; then
  for script in "$POST_SCRIPTS_DIR"/*.sh; do
    run_script "$script"
  done
else
  echo "No post-scripts found in ${POST_SCRIPTS_DIR}. Skipping post-scripts."
fi

echo "All done."
