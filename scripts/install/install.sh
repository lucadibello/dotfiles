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

OS_NAME="$(uname -s)"

run_script() {
  local script="$1"
  echo "Running $script..."
  bash "$script"
  if [ $? -ne 0 ]; then
    echo "❌ $script failed. Check the logs for more information."
    exit 1
  fi
}

# Function to create a symbolic link with a prompt if the file already exists
create_symlink() {
  local source_file="$1"
  local target_file="$2"

  # Create the directory if it does not exist
  mkdir -p "$(dirname "$target_file")"

  if [ -L "$target_file" ]; then
    # If the target is a symbolic link, remove it
    echo -e "\t$target_file is a symbolic link. Removing it."
    rm "$target_file"
  fi

  if [ -e "$target_file" ]; then
    # If the target exists and is not a symbolic link, prompt the user
    echo -e "\t$target_file already exists."
    while true; do
      echo -en "\tDo you want to replace it? (y/n): "
      read -r yn
      case $yn in
      [Yy]*)
        rm -f "$target_file"
        if [ $? -ne 0 ]; then
          echo -e "\tFailed to remove $target_file. Skipping." >&2
          return 1
        fi
        ln -s "$source_file" "$target_file"
        if [ $? -eq 0 ]; then
          echo -e "\t$target_file has been replaced."
        else
          echo -e "\tFailed to create symlink for $target_file." >&2
          return 1
        fi
        break
        ;;
      [Nn]*)
        echo -e "\tSkipped $target_file."
        return 0
        ;;
      *)
        echo -e "\tPlease answer yes or no."
        ;;
      esac
    done
  else
    ln -s "$source_file" "$target_file"
    if [ $? -eq 0 ]; then
      echo -e "\t$target_file has been created."
    else
      echo -e "\tFailed to create symlink for $target_file." >&2
      return 1
    fi
  fi
  return 0
}

# Execute all scripts in the pre-scripts directory
echo "🏃 Running pre-scripts..."
if [ -d "$PRE_SCRIPTS_DIR" ] && [ -n "$(ls -A "$PRE_SCRIPTS_DIR" 2>/dev/null)" ]; then
  for script in "$PRE_SCRIPTS_DIR"/*.sh; do
    run_script "$script"
  done
else
  echo "No pre-scripts found in ${PRE_SCRIPTS_DIR}. Skipping pre-scripts."
fi

echo "🏁 Done. Your system is ready for setup."
echo "📦 Moving dotfiles to the respective directories..."

echo "* Setting up fish..."
create_symlink "$REPO_ROOT/config.fish" "$HOME/.config/fish/config.fish"

echo "* Setting up tmux..."
mkdir -p "$HOME/.config/tmux"
if [ "$OS_NAME" = "Linux" ] && [ -f "$REPO_ROOT/.tmux.linux.conf" ]; then
  create_symlink "$REPO_ROOT/.tmux.linux.conf" "$HOME/.tmux.conf"
else
  create_symlink "$REPO_ROOT/.tmux.conf" "$HOME/.tmux.conf"
  # this needed for tmux inside dockerized linux containers
  create_symlink "$REPO_ROOT/.tmux.linux.conf" "$HOME/.tmux.linux.conf"
fi

echo "* Setting up kitty..."
create_symlink "$REPO_ROOT/kitty.conf" "$HOME/.config/kitty/kitty.conf"

echo "* Setting up zathura..."
create_symlink "$REPO_ROOT/zathurarc" "$HOME/.config/zathura/zathurarc"

echo "* Setting up starship..."
create_symlink "$REPO_ROOT/starship.toml" "$HOME/.config/starship.toml"

echo "* Setting up aero-space..."
create_symlink "$REPO_ROOT/.aerospace.toml" "$HOME/.aerospace.toml"

echo "* Setting up bordersrc..."
create_symlink "$REPO_ROOT/bordersrc" "$HOME/.config/borders/bordersrc"

echo "* Setting up Ghostty..."
create_symlink "$REPO_ROOT/ghostty.config" "$HOME/.config/ghostty/config"
create_symlink "$REPO_ROOT/scripts/tmux/tmux-attach.sh" "$HOME/.config/ghostty/tmux-attach.sh"

# Execute all scripts in the post-scripts directory
echo "🏃 Running post-scripts..."
if [ -d "$POST_SCRIPTS_DIR" ] && [ -n "$(ls -A "$POST_SCRIPTS_DIR" 2>/dev/null)" ]; then
  for script in "$POST_SCRIPTS_DIR"/*.sh; do
    run_script "$script"
  done
else
  echo "No post-scripts found in ${POST_SCRIPTS_DIR}. Skipping post-scripts."
fi

echo "🏁 Your system is ready for use."
