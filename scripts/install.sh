#!/bin/zsh

# Function to create a symbolic link with a prompt if the file already exists
create_symlink() {
    local source_file=$1
    local target_file=$2

    if [ -L "$target_file" ]; then
        # If the target is a symbolic link, remove it
        echo "$target_file is a symbolic link. Removing it."
        rm "$target_file"
    fi
    if [ -e "$target_file" ]; then
        # If the target exists and is not a symbolic link, prompt the user
        echo "$target_file already exists."
        while true; do
            echo "Do you want to replace it? (y/n): "
            read yn
            case $yn in
                [Yy]* )
                    rm -f "$target_file"
                    if [ $? -ne 0 ]; then
                        echo "Failed to remove $target_file. Skipping."
                        return
                    fi
                    ln -s "$source_file" "$target_file"
                    if [ $? -eq 0 ]; then
                        echo "$target_file has been replaced."
                    else
                        echo "Failed to create symlink for $target_file."
                    fi
                    break;;
                [Nn]* )
                    echo "Skipped $target_file."
                    return;;
                * )
                    echo "Please answer yes or no.";;
            esac
        done
    else
        ln -s "$source_file" "$target_file"
        if [ $? -eq 0 ]; then
            echo "$target_file has been created."
        else
            echo "Failed to create symlink for $target_file."
        fi
    fi
}

# Move all the dotfiles in the respective directories

# 1. zshrc
echo "Setting up zshrc..."
create_symlink "$(pwd)/.zshrc" ~/.zshrc

# 2. tmux.conf
echo "Setting up tmux.conf..."
create_symlink "$(pwd)/.tmux.conf" ~/.tmux.conf
