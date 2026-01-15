# Rommert Zijlstra's .zshrc
[[ -n "$ENABLE_ZPROF" ]] && zmodload zsh/zprof

# options
setopt AUTO_NAME_DIRS
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS
setopt LONG_LIST_JOBS
setopt PROMPT_SUBST
setopt PUSHD_IGNORE_DUPS

# history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

[[ -z "$HISTFILE" ]] && HISTFILE="$HOME/.zsh_history"
[[ "$HISTSIZE" -lt 50000 ]] && HISTSIZE=50000
[[ "$SAVEHIST" -lt 10000 ]] && SAVEHIST=10000

# path settings
fpath=(
  "$HOME/.config/zsh/completions"
  $fpath
)

path=(
  $HOME/.local/bin
  $HOME/.local/share/mise/shims
  $HOME/node_modules/.bin

  $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
  $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin
  $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin
  $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin
  $HOMEBREW_PREFIX/opt/gnu-getopt/bin
  $HOMEBREW_PREFIX/opt/grep/libexec/gnubin

  # Heroku pg:psql
  $HOMEBREW_PREFIX/opt/postgresql@17/bin

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
