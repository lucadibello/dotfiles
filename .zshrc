#!/bin/zsh

# Path to the oh-my-zsh installation folder
export ZSH="$HOME/.oh-my-zsh"

# auto-update behavior
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 13

# Additional settings
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  you-should-use
  zsh-vi-mode
)

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Define aliases
alias mux='tmuxinator'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Update PATH with some additional tools 

# 1. Golang
export PATH="$PATH:$(go env GOPATH)/bin"

# 2. OpenJDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Start oh-my-zsh
source $ZSH/oh-my-zsh.sh

## Start additional tools

# Start spaceship
eval "$(starship init zsh)"
# Start Zoxide
eval "$(zoxide init zsh)"
