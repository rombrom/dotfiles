#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install core utilities
brew install bat
brew install boxes
brew install coreutils
brew install dive
brew install dnsmasq
brew install fd
brew install ffmpeg
brew install findutils
brew install fzf
brew install gawk
brew install gh
brew install git
brew install git-lfs
brew install gnu-getopt
brew install gnu-sed
brew install gnu-tar
brew install gojq
brew install grep
brew install helix
brew install hexyl
brew install imagemagick
brew install jj
brew install llama.cpp
brew install neovim
brew install nmap
brew install oha
brew install pandoc
brew install ripgrep
brew install stow
brew install tree
brew install watchexec
brew install wget
brew install zsh
brew install zsh-completions
brew install universal-ctags

# Containers
brew install docker
brew install docker-compose
brew install colima
brew services start colima

# Some dev deps
# brew install lua luarocks lua-language-server
# brew install shellcheck
brew install postgresql@17

# At some point I'll switch to some version manager. Maybe.
# EDIT: I did.
brew install mise
# libraries for mise dependencies. ok
brew install libpq
brew install openssl
brew install ruby-lsp

# install casks
brew install --cask --force 1password
brew install --cask --force appcleaner
brew install --cask --force brave-browser
brew install --cask --force discord
brew install --cask --force disk-inventory-x
brew install --cask --force docker
brew install --cask --force figma
brew install --cask --force firefox@developer-edition
brew install --cask --force google-chrome@beta
brew install --cask --force kitty
brew install --cask --force slack
brew install --cask --force steam
brew install --cask --force telegram
brew install --cask --force visual-studio-code
brew install --cask --force vlc
brew install --cask --force whatsapp

# iTunes + Discord
brew tap nextfire/tap
brew install apple-music-discord-rpc
brew services restart apple-music-discord-rpc

# fix zsh-completion directory permissions
chmod -R go-w "$HOMEBREW_PREFIX/share/zsh"

# Remove outdated versions from the cellar.
brew cleanup
