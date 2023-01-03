autoload -U add-zsh-hook
autoload -Uz vcs_info

setopt PROMPT_SUBST

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' ⌥'
zstyle ':vcs_info:*' unstagedstr ' +'
zstyle ':vcs_info:*' formats '%F{12}%16<…<%b%<<%F{3}%c%u%f '
zstyle ':vcs_info:*' actionformats '%F{12}%b %F{11}%a%F{3}%c%u%f '

PS1='%B%F{4}$(__gobble $PWD)%f ${vcs_info_msg_0_}%F{8}%#%f%b '
RPS1='%F{8}%T%f'

add-zsh-hook precmd vcs_info
add-zsh-hook precmd title_init

function title_init {
  print -Pn "\e]0;$(__gobble $PWD)\a"
}

function __gobble() {
  local str=${(D)1}
  local max=${2:-16}
  local sep=${3:-/}

  local parts=(${(ps:$sep:)${str}})

  if [[ $str = $sep* ]]; then
    parts=('' $parts)
  fi

  for (( i = 1; i < $#parts; i++ )); do
    local part=$parts[$i]

    if [[ ${#${(pj:$sep:)parts}} > $max ]]; then
      if [[ $part =~ '^\.' ]]; then
        parts[$i]=$part[0,2]
      else
        parts[$i]=$part[0,1]
      fi
    fi
  done

  print ${(pj:$sep:)parts}
}

function __redraw() {
  local precmd
  for precmd in $precmd_functions; do
    $precmd
  done
  zle reset-prompt
}

TOGGLED=
function expand-prompt() {
  TOGGLED=$((1-TOGGLED))

  if ! (( $TOGGLED )); then
    zstyle ':vcs_info:*' formats '%F{12}%16<…<%b%<<%F{3}%c%u%f '
    PS1='%B%F{4}$(__gobble $PWD)%f ${vcs_info_msg_0_}%F{8}%#%f%b '
  else
    zstyle ':vcs_info:*' formats '%F{12}%b%F{3}%c%u%f '
    PS1='%B%F{4}%~%f ${vcs_info_msg_0_}%F{8}%#%f%b '
  fi

  __redraw
}

zle -N expand-prompt
bindkey '\C-x\C-x' expand-prompt
