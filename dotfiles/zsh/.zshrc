# /* vim: set filetype=zsh : */

[[ -n "$ENABLE_ZPROF" ]] && zmodload zsh/zprof

# path settings
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

# plugins (loaded before compinit)
[[ ! -d "$HOME/.zinit" ]] && \
  git clone --depth=1 https://github.com/zdharma/zinit.git ~/.zinit/bin

source "$HOME/.zinit/bin/zinit.zsh"

zinit wait lucid for \
  depth'1' pick"contrib/completion/zsh" docker/cli \
  depth'1' pick"contrib/completion/zsh" docker/compose

# NOTE: VIM mode needs to be set explicitly, I think, because EDITOR is is
# probably unset in macOS global env. Also, we want to set it here before
# zle.zsh (or other bindings) are loaded.
bindkey -v

# load config files
for file ($HOME/.config/zsh/**/*); do
  [[ -f "$file" ]] && source "$file"
done;

[[ -n "$ENABLE_ZPROF" ]] && zprof
