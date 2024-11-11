#!/bin/bash

# Useful paths
PRE_SCRIPTS_DIR="./scripts/install/pre"
POST_SCRIPTS_DIR="./scripts/install/post"

# Enable null_glob to prevent errors when no files are found
setopt null_glob

run_script() {
  local script=$1
  echo "Running $script..."
  zsh $script
  if [ $? -ne 0 ]; then
    echo "❌ $script failed. Check the logs for more information."
    exit 1
  fi
}

# Function to create a symbolic link with a prompt if the file already exists
create_symlink() {
  local source_file=$1
  local target_file=$2

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
      read yn
      case $yn in
      [Yy]*)
        rm -f "$target_file"
        if [ $? -ne 0 ]; then
          echo -e "\tFailed to remove $target_file. Skipping." >&2
          return 1 # Return error code if unable to remove the file
        fi
        ln -s "$source_file" "$target_file"
        if [ $? -eq 0 ]; then
          echo -e "\t$target_file has been replaced."
        else
          echo -e "\tFailed to create symlink for $target_file." >&2
          return 1 # Return error code if symlink creation fails
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
      return 1 # Return error code if symlink creation fails
    fi
  fi
  return 0 # Successful execution
}
# Execute all scrips in the pre-scripts directory
echo "🏃 Running pre-scripts..."

# Check if the directory contains any files
if [ -z "$(ls -A $PRE_SCRIPTS_DIR 2>/dev/null)" ]; then
  echo "\tNo post-scripts found in $POST_SCRIPTS_DIR."
  exit 0
fi

for script in $PRE_SCRIPTS_DIR/*.sh; do
  run_script $script
done

echo "🏁 Done. Your system is ready for setup."

echo "📦 Moving dotfiles to the respective directories..."

# 1. Fish
echo "* Setting up fish..."
create_symlink "$(pwd)/config.fish" ~/.config/fish/config.fish

# 2. TMUX
echo "* Setting up tmux..."
create_symlink "$(pwd)/.tmux.conf" ~/.tmux.conf

# 3. Kitty
echo "* Setting up kitty..."
create_symlink "$(pwd)/kitty.conf" ~/.config/kitty/kitty.conf
create_symlink "$(pwd)/scripts/kitty/tmux-attach.sh" ~/.config/kitty/tmux-attach.sh

# 4. Zathura
echo "* Setting up zathura..."
create_symlink "$(pwd)/zathurarc" ~/.config/zathura/zathurarc

# Execute all scrips in the post-scripts directory
echo "🏃 Running post-scripts..."
# Check if the directory contains any files
if [ -z "$(ls -A $POST_SCRIPTS_DIR 2>/dev/null)" ]; then
  echo "\tNo post-scripts found in $POST_SCRIPTS_DIR."
else
  # Loop over the scripts if files are present
  for script in $POST_SCRIPTS_DIR/*; do
    run_script $script
  done
fi

echo "🏁 Your system is ready for use."

# Reset null_glob
set no_null_glob
