# Set default language
export LANG=en_US.UTF-8
export LC_ALL='en_US.UTF-8';

# Set defailt editor
export EDITOR="code"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty);

# Make fzf use ripgrep by default
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Update $PATH with homebrew coreutils
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
