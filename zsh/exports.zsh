# Set defailt editor to atom
export EDITOR="atom"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Update $PATH with homebrew coreutils
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
