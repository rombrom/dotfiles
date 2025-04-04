# Rommert Zijlstra's .zshrc
[[ -n "$ENABLE_ZPROF" ]] && zmodload zsh/zprof

# path settings
fpath=(
  "$HOME/.config/zsh/completions"
  $fpath
)

path=(
  $HOME/.cargo/bin
  $HOME/.foundry/bin
  $HOME/.local/bin
  $HOME/.local/share/mise/shims
  $HOME/node_modules/.bin

  $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
  $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin
  $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin
  $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin
  $HOMEBREW_PREFIX/opt/gnu-getopt/bin
  $HOMEBREW_PREFIX/opt/grep/libexec/gnubin
  $HOMEBREW_PREFIX/opt/openjdk/bin

  $path
)

manpath=(
  $HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman
  $HOMEBREW_PREFIX/opt/findutils/libexec/gnuman
  $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnuman
  $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman
  $HOMEBREW_PREFIX/opt/grep/libexec/gnuman
  $manpath
)

cdpath=(
  $HOME/Code
  $HOME
)

# NOTE: LS_COLORS will be used by the completion settings to set completion
# colors. Can't define it in exports.
export LS_COLORS='no=0;37:fi=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:';

# load config files
for file ($HOME/.config/zsh/*); do
  [[ -f "$file" ]] && source "$file"
done;

[[ -n "$ENABLE_ZPROF" ]] && zprof
