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

# VIM manpager \m/
export MANPAGER='col -bx | vim -MR +MANPAGER -'
export BAT_THEME='ansi' # TODO: create a bat theme based on bluebox

# Avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty);

# Make fzf use ripgrep by default
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_DEFAULT_OPTS="--border --height 40% --layout=reverse --tiebreak=length,end \
  --color='16,bg+:-1,fg+:4,gutter:-1,hl:3,hl+:3,pointer:4,prompt:6'"
