# Git helpers shared across shells
alias gcof="git branch --sort=-committerdate | fzf | xargs git checkout"
alias gg="git log --all --decorate --oneline --graph"
