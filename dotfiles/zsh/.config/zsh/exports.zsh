# Set default language
export LANG=en_US.UTF-8
export LC_ALL='en_US.UTF-8'

# Set default editor
export VISUAL="hx"
export EDITOR="hx"

# Reduce ESC delay in zsh vi-mode
export KEYTIMEOUT=1

# Make commands use colors if possible
export CLICOLOR=yes

# Batpager
export MANPAGER='col -b | bat --language=man --plain'

# Avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$TTY

# Ripgrep config
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Ruby/Rails 🤷‍♂️
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES;
