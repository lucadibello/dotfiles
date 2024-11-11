#!/bin/bash

# Install useful fisher plugins!

# Install + configure tide
fisher install IlanCosman/tide@v6
tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time=No --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No

# Install autopair
fisher install jorgebucaran/autopair.fish
