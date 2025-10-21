#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

OH_MY_DIR="${HOME}/.oh-my-zsh"

if [[ -d "${OH_MY_DIR}" ]]; then
  echo "oh-my-zsh already installed at ${OH_MY_DIR}; skipping clone."
  exit 0
fi

if ! command -v git &>/dev/null; then
  echo "git is required to install oh-my-zsh. Install git and re-run."
  exit 1
fi

echo "Cloning oh-my-zsh into ${OH_MY_DIR}..."
git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "${OH_MY_DIR}"
echo "oh-my-zsh installed."
