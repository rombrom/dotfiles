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

bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
