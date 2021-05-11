zmodload -i zsh/complist
autoload -U compinit && compinit

unsetopt MENU_COMPLETE
unsetopt FLOW_CONTROL
setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt COMPLETE_IN_WORD

zstyle ':completion:*' list-colors ''
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:*:*:*' menu select=1 _complete _ignored _approximate

# kitty completion
[[ "$TERM" = "xterm-kitty" ]] && \
  kitty +complete setup zsh | source /dev/stdin
