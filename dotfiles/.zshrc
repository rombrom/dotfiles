# # Disable completion permission check (when current user has not installed zsh)
# ZSH_DISABLE_COMPFIX=true

# # Path to your oh-my-zsh installation.
# export ZSH=$HOME/.oh-my-zsh

# # Set name of the theme to load. Optionally, if you set this to "random"
# # it'll load a random theme each time that oh-my-zsh is loaded.
# # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(
#   colored-man-pages
#   docker
#   docker-compose
#   git
#   git-extras
#   urltools
#   z
# )

# source "$ZSH/oh-my-zsh.sh"

# # # # # # # # # # # #
# Removal in progress #
# # # # # # # # # # # #

path=(
  /usr/local/opt/coreutils/libexec/gnubin
  /usr/local/opt/findutils/libexec/gnubin
  /usr/local/opt/gnu-tar/libexec/gnubin
  /usr/local/opt/gnu-sed/libexec/gnubin
  /usr/local/opt/gnu-getopt/bin
  /usr/local/opt/grep/libexec/gnubin
  $path[@]
)

manpath=(
  /usr/local/opt/coreutils/libexec/gnuman
  /usr/local/opt/findutils/libexec/gnuman
  /usr/local/opt/gnu-tar/libexec/gnuman
  /usr/local/opt/gnu-sed/libexec/gnuman
  /usr/local/opt/grep/libexec/gnuman
  "$manpath[@]"
)

setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS
setopt LONG_LIST_JOBS

source "$HOME/.config/zsh/exports.zsh"

source "$HOME/.config/zsh/prompt.zsh"
source "$HOME/.config/zsh/completion.zsh"
source "$HOME/.config/zsh/history.zsh"
source "$HOME/.config/zsh/zle.zsh"

source "$HOME/.config/zsh/functions.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/fzf.zsh"
