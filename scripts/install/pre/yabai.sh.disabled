#!/bin/bash

#
# Source: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)
#

# Start yabai service as root without sudo
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai

# Ensure that .yabairc is executable
chmod +x .yabairc
