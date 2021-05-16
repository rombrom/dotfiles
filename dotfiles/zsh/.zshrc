# /* vim: set filetype=zsh : */

[[ -n "$ENABLE_ZPROF" ]] && zmodload zsh/zprof

path=(
  "$HOME/.local/bin"
  /usr/local/opt/coreutils/libexec/gnubin
  /usr/local/opt/findutils/libexec/gnubin
  /usr/local/opt/gnu-tar/libexec/gnubin
  /usr/local/opt/gnu-sed/libexec/gnubin
  /usr/local/opt/gnu-getopt/bin
  /usr/local/opt/grep/libexec/gnubin
  /usr/local/opt/node@12/bin
  /usr/local/opt/python@3.9/libexec/bin
  $path
)

manpath=(
  /usr/local/opt/coreutils/libexec/gnuman
  /usr/local/opt/findutils/libexec/gnuman
  /usr/local/opt/gnu-tar/libexec/gnuman
  /usr/local/opt/gnu-sed/libexec/gnuman
  /usr/local/opt/grep/libexec/gnuman
  $manpath
)

cdpath=(
  "$HOME/Code"
)

source "$HOME/.config/zsh/options.zsh"
source "$HOME/.config/zsh/exports.zsh"
source "$HOME/.config/zsh/functions.zsh"
source "$HOME/.config/zsh/aliases.zsh"

# plugins {{{
  # ideally loaded before ccmpinit
  [[ ! -d "$HOME/.zinit" ]] && \
    git clone --depth=1 https://github.com/zdharma/zinit.git ~/.zinit/bin

  source "$HOME/.zinit/bin/zinit.zsh"

  zinit wait lucid for \
    depth'1' pick"contrib/completion/zsh" docker/cli \
    depth'1' pick"contrib/completion/zsh" docker/compose
# }}}

source "$HOME/.config/zsh/completion.zsh"
source "$HOME/.config/zsh/prompt.zsh"
source "$HOME/.config/zsh/zle.zsh"

# vendor
source "$HOME/.config/zsh/fzf.zsh"

[[ -n "$ENABLE_ZPROF" ]] && zprof
