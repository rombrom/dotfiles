# Rommert Zijlstra's .zshrc

[[ -n "$ENABLE_ZPROF" ]] && zmodload zsh/zprof

# path settings
fpath=(
  "$HOME/.config/zsh/completions"
  $fpath
)

path=(
  "$HOME/.local/bin"
  "$HOME/node_modules/.bin"
  /usr/local/opt/coreutils/libexec/gnubin
  /usr/local/opt/findutils/libexec/gnubin
  /usr/local/opt/gnu-tar/libexec/gnubin
  /usr/local/opt/gnu-sed/libexec/gnubin
  /usr/local/opt/gnu-getopt/bin
  /usr/local/opt/grep/libexec/gnubin
  /usr/local/opt/python@3.9/libexec/bin
  /usr/local/opt/openjdk/bin
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
  $HOME/Code
  $HOME
)

# NOTE: VIM mode needs to be set explicitly, I think, because EDITOR is is
# probably unset in macOS global env. Also, we want to set it here before
# zle.zsh (or other bindings) are loaded.
bindkey -v

# NOTE: LS_COLORS will be used by the completion settings to set completion
# colors. Can't define it in exports.
# TODO: back to a custom load order?
export LS_COLORS='no=0;37:fi=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:';

# load config files
for file ($HOME/.config/zsh/*); do
  [[ -f "$file" ]] && source "$file"
done;

[[ -n "$ENABLE_ZPROF" ]] && zprof
