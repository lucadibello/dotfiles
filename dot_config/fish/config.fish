# add important paths to fish's PATH env

# Additional settings for Fish
set -U fish_autosuggestion_enabled
set -U fish_hybrid_mode # Vi-style keybindings

# Settings for Done package
set -U __done_min_cmd_duration 5000 # Send notification if command takes more than 5 seconds
set -U __done_notify_sound 1 # Play notification sound

# Use vi keybindings in fish
fish_vi_key_bindings

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" hook $argv | source
# <<< conda initialize <<<

# PATH setup
# Golang
set -x PATH $PATH (go env GOPATH)/bin
# jenv (java version manager)
set -x PATH /opt/homebrew/opt/openjdk/bin $PATH
# LLVM
set -x PATH /opt/homebrew/opt/llvm/bin $PATH

# openjdk (disabled, using jenv)
# set -x PATH /opt/homebrew/opt/openjdk/bin $PATH

# Constants
set -x CXX clang++
set -x CC clang

# Start Starship prompt
starship init fish | source

# Zoxide setup (install with fisher: fisher install ajeetdsouza/zoxide)
zoxide init fish | source

# Start Atuin
atuin init fish | source

# Start jenv
status --is-interactive; and jenv init - | source

# Change welcome message
function fish_greeting
    echo "🚀 another day, another terminal"
end
