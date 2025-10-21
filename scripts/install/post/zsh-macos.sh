#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# Run only on macOS
if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Not macOS; skipping default shell change."
  exit 0
fi

ZSH_BIN="$(command -v zsh || true)"

if [[ -z "${ZSH_BIN}" ]]; then
  echo "zsh not found; skipping default shell change."
  exit 0
fi

CURRENT_SHELL="${SHELL:-}"
if [[ "${CURRENT_SHELL}" == "${ZSH_BIN}" ]]; then
  echo "zsh is already the default shell."
  exit 0
fi

if ! grep -q "^${ZSH_BIN}$" /etc/shells; then
  echo "Adding zsh to /etc/shells..."
  echo "${ZSH_BIN}" | sudo tee -a /etc/shells >/dev/null
fi

echo "Setting zsh (${ZSH_BIN}) as the default shell..."
export SHELL="${ZSH_BIN}"
chsh -s "${ZSH_BIN}"
echo "zsh has been set as the default shell. Restart your terminal for the change to take effect."
