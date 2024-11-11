# Additional settings for Fish
set -g fish_key_bindings fish_vi_key_bindings # equivalent to zsh-vi-mode
set -U fish_autosuggestion_enabled
set -U fish_hybrid_mode # Vi-style keybindings

# Aliases
alias mux="tmuxinator"

# Editor setup
if test -n "$SSH_CONNECTION"
    set -x EDITOR vim
else
    set -x EDITOR nvim
end

# Set shell to fish
set -x SHELL /opt/homebrew/bin/fish

# Language setup
set -x LANG en_US.UTF-8

# Conda initialization
if test -f /opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.fish
    source /opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.fish
else
    set -x PATH /opt/homebrew/Caskroom/miniconda/base/bin $PATH
end

# PATH setup
# Golang
set -x PATH $PATH (go env GOPATH)/bin
# OpenJDK
set -x PATH /opt/homebrew/opt/openjdk/bin $PATH
# LLVM
set -x PATH /opt/homebrew/opt/llvm/bin $PATH

# Constants
set -x CXX clang++
set -x CC clang

# Start Starship prompt
# starship init fish | source

# Zoxide setup (install with fisher: fisher install ajeetdsouza/zoxide)
zoxide init fish | source
