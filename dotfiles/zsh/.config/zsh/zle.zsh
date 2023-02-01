autoload -U edit-command-line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

bindkey -M menuselect "${terminfo[kcbt]}" reverse-menu-complete
bindkey -M menuselect "^P" reverse-menu-complete
bindkey -M menuselect "^N" menu-complete

bindkey ' ' magic-space # [Space] - don't do history expansion

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\C-p' up-line-or-beginning-search
bindkey '\C-n' down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

bindkey '\C-x\C-i' _complete_help

# Shamelessly borrowed from
# https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
# 🙏
function __czcz() {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}

zle -N __czcz
bindkey '\C-z' __czcz
