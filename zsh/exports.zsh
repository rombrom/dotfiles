# Set default language
export LANG=en_US.UTF-8
export LC_ALL='en_US.UTF-8';

# Set default editor
export VISUAL="vim"
export EDITOR="vim"

# Reduce ESC delay in zsh vi-mode
export KEYTIMEOUT=1

# Make commands use colors if possible
export CLICOLOR=yes

#  Highlight section titles in manual pages.
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
# The following line increases zsh startup with ~1s
# export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
# So instead we'll roll with the absolute option
export PATH=$PATH:/usr/local/opt/coreutils/libexec/gnubin
