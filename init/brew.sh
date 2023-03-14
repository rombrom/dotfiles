#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# prepare taps
brew tap universal-ctags/universal-ctags

# Libraries
brew install libusb # required by https://getfoundry.sh/

# Install core utilities
brew install act
brew install bat
brew install bats-core
brew install boxes
brew install cmake
brew install coreutils
brew install deno
brew install dive
brew install dnsmasq
brew install fd
brew install findutils
brew install fzf
brew install gawk
brew install gh
brew install ghostscript
brew install git
brew install gnu-getopt
brew install gnu-sed
brew install gnu-tar
brew install gojq
brew install grep
brew install helix
brew install hexyl
brew install imagemagick
brew install nmap
brew install pandoc
brew install postman
brew install ripgrep
brew install stow
brew install tree
brew install vim
brew install watchexec
brew install wget
brew install zsh
brew install zsh-completions
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# Some dev deps
brew install lua luarocks lua-language-server
brew install shellcheck

# At some point I'll switch to some version manager. Maybe.
brew install node corespack
brew install node@18
brew install node@16

# install casks
brew install --cask 1password
brew install --cask appcleaner
brew install --cask brave-browser
brew install --cask docker
brew install --cask discord
brew install --cask figma
brew install --cask homebrew/cask-versions/firefox-developer-edition
brew install --cask homebrew/cask-versions/google-chrome-beta
brew install --cask kitty
brew install --cask linear-linear
brew install --cask notion
brew install --cask visual-studio-code
brew install --cask steam
brew install --cask telegram
brew install --cask whatsapp

# iTunes + Discord
brew tap nextfire/tap
brew install apple-music-discord-rpc
brew services restart apple-music-discord-rpc

# fix zsh-completion directory permissions
chmod -R go-w "$HOMEBREW_PREFIX/share/zsh"

# Remove outdated versions from the cellar.
brew cleanup
