zmodload -i zsh/complist
autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit

unsetopt MENU_COMPLETE
unsetopt FLOW_CONTROL
setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt COMPLETE_IN_WORD

zstyle ':completion:*' list-colors ${(s.:.)"$(dircolors)"}
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' group-name ''
zstyle ':completion:*' rehash true

# case-insensitive matching
zstyle ':completion:*' matcher-list \
  'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'

zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*:*:*:*:*' menu select=1 _complete _ignored _approximate

zstyle ':completion:*:descriptions' format '%F{8}# %d:%f'

zstyle ':completion:*:*:-tilde-:*:*' ignored-patterns '_*'

zstyle ':completion:*:(cd|pushd):*' tag-order \
  'local-directories named-directories directory-stack path-directories'

# ignore zsh completion functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# kitty completion
[[ "$TERM" = "xterm-kitty" ]] && \
  kitty +complete setup zsh | source /dev/stdin

# use caching
zstyle ':completion::complete:*' use-cache true
