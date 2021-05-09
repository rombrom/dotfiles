autoload -U up-line-or-beginning-search down-line-or-beginning-search

bindkey -v

bindkey -M menuselect "${terminfo[kcbt]}" reverse-menu-complete
bindkey -M menuselect "^P" reverse-menu-complete
bindkey -M menuselect "^N" menu-complete

bindkey ' ' magic-space # [Space] - don't do history expansion

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M viins "^P" up-line-or-beginning-search
bindkey -M viins "^N" down-line-or-beginning-search

bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
