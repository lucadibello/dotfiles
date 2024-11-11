#!/bin/bash

# Install useful fisher plugins!

# Install + configure tide
fish -c "fisher install IlanCosman/tide@v6"
fish -c "tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time=No --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No"

# Install autopair
fish -c "fisher install jorgebucaran/autopair.fish"
