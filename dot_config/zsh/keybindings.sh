# Git helpers shared across shells
alias gcof="git branch -a --sort=-committerdate | fzf --tac | sed 's/\\*//' | sed 's/remotes\/origin\///' | tr -d ' ' | xargs git checkout"
alias gg="git log --all --decorate --oneline --graph"
