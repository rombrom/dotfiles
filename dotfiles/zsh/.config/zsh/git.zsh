# aliases
alias ga='git add'
alias gb='git branch'
alias gba='git branch --all'
alias gc='git commit -v'
alias gca='git commit -av'
alias gcb='git checkout -b'
alias gcl='git clone'
alias gcm='git checkout master'
alias gcn='git commit -v --no-verify'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch --prune'
alias gl='git pull'
alias glg='git log --abbrev-commit --date=relative --stat'
alias glo='git log --oneline'
alias gm='git merge'
alias gp='git push origin HEAD'
alias gpn='git push origin HEAD --no-verify'
alias gr='git rebase'
alias grh='git reset --hard'
alias grm='git rebase master'
alias gss='git status --short'

# fuzzy git stuff
alias gcof="git checkout \$( \
  git branch --all --sort -committerdate | grep -v '^*' | \
  fzf --preview 'git log --color --oneline {1}' \
  )"

alias gbfd="git branch -D \$( \
  git branch --sort -committerdate | grep -v '^*' | \
  fzf --multi --preview 'git log --color --oneline {1}' \
  )"
