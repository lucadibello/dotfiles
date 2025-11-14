#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

VENV_DIR="${HOME}/.virtualenvs/neovim"
VENV_PYTHON="${VENV_DIR}/bin/python"
VENV_PIP="${VENV_DIR}/bin/pip3"
PYTHON_BIN="${PYTHON_BIN:-python3}"
NPM_BIN="${NPM_BIN:-npm}"

if ! command -v "${PYTHON_BIN}" >/dev/null 2>&1; then
  echo "python3 is required to manage the Neovim virtualenv. Install python3 and re-run the installer."
  exit 1
fi

if [[ ! -x "${VENV_PYTHON}" ]]; then
  echo "Creating Neovim virtualenv at ${VENV_DIR}..."
  mkdir -p "$(dirname "${VENV_DIR}")"
  "${PYTHON_BIN}" -m venv "${VENV_DIR}"
else
  echo "Neovim virtualenv already exists at ${VENV_DIR}; skipping creation."
fi

echo "Ensuring pynvim + jupyter dependencies (for molten.nvim) is installed in ${VENV_DIR}..."
"${VENV_PYTHON}" -m pip install --upgrade pip >/dev/null 2>&1 || true
"${VENV_PIP}" install --upgrade pynvim jupytext jupyter cairosvg plotly kaleido pnglatex pyperclip

echo "Ensuring markdown-renderer dependencies are installed in ${VENV_DIR}..."
"${VENV_PIP}" install --upgrade pylatexenc

echo "Installing additional general purpose Python packages in ${VENV_DIR}..."
"${VENV_PIP}" install --upgrade pandas numpy matplotlib seaborn scipy

if ! command -v "${NPM_BIN}" >/dev/null 2>&1; then
  echo "npm is required to install the Neovim Node.js client. Install npm and re-run the installer."
  exit 1
fi

if "${NPM_BIN}" list -g neovim --depth=0 >/dev/null 2>&1; then
  echo "neovim npm package already installed globally; skipping."
else
  echo "Installing neovim npm package globally..."
  "${NPM_BIN}" install -g neovim
fi

echo "Installing Prettier globally..."
"${NPM_BIN}" install -g prettier

echo "Neovim Python and Node.js dependencies are ready."
