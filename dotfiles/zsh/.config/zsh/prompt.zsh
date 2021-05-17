autoload -U add-zsh-hook
autoload -Uz vcs_info

setopt PROMPT_SUBST

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' ⌥'
zstyle ':vcs_info:*' unstagedstr ' +'
zstyle ':vcs_info:*' formats '%F{12}%b%f%F{3}%c%u%f '

add-zsh-hook precmd vcs_info

PS1='%B%F{4}%.%f ${vcs_info_msg_0_}%F{8}%#%f%b '
RPS1='%F{8}%T%f'
