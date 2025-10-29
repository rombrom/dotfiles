# experiment
function g() {
  [[ $# -eq 0 ]] && $EDITOR +G +only
  [[ $# -gt 0 ]] && git $@
}

# aliases
alias ga='git add'
alias gb='git branch'
alias gba='git branch --all'
alias gc='git commit -v'
alias gca='git commit -av'
alias gce='git commit -av --amend --no-edit'
alias gcf='git clean -df'
alias gcl='git clone'
alias gcm='git checkout main'
alias gcn='git commit -v --no-verify'
alias gd='git diff'
alias gf='git fetch --prune'
alias gl='git pull'
alias glg='git log --abbrev-commit --date=relative --stat'
alias glo='git log --oneline'
alias gm='git merge'
alias gp='git push origin HEAD'
alias gpf='git push origin HEAD --force-if-includes --force-with-lease'
alias gpn='git push origin HEAD --no-verify'
alias gr='git rebase'
alias grh='git reset --hard'
alias gss='git status --short'

function gco() {
  if [[ "$#" -eq 0 ]]; then
    local branches="$( \
      git --no-pager branch --all | \
      grep -Ev '(^[*+]|HEAD)' | \
      sed -E 's#[[:blank:]]*(remotes/([[:alnum:]/-]+))?#\2#'
    )"
    local tags="$(git --no-pager tag)"
    local ref="$( \
      (echo $branches; echo $tags) | \
      fzf --multi --preview 'git log --color --oneline {1}' \
    )"
    [[ ! -z "$ref" ]] && git checkout "$ref"
  else
    git checkout $@
  fi
}

alias gbd="git branch -D \$( \
  git branch | grep -v '^\*' | \
  fzf --multi --preview 'git log --color --oneline {1}' \
  )"

compdef -e 'words[1]=(git checkout); service=git; (( CURRENT+=1 )); _git' gco
