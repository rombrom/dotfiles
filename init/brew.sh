#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# prepare taps
brew tap universal-ctags/universal-ctags

# Install core utilities
brew install azure-cli
brew install bat
brew install bats-core
brew install coreutils
brew install cmake
brew install dnsmasq
brew install fd
brew install findutils
brew install fzf
brew install gawk
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
brew install node
brew install pandoc
brew install postman
brew install ripgrep
brew install shellcheck
brew install stow
brew install tree
brew install vim
brew install watchexec
brew install watchman
brew install wget
brew install zsh
brew install zsh-completions
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# Install Recent Python
brew install python

# Clojure experiments
#brew install clojure java leiningen

# fix zsh-completion directory permissions
chmod -R go-w "$HOMEBREW_PREFIX/share/zsh"

# install casks
brew install --cask 1password
brew install --cask appcleaner
brew install --cask docker
brew install --cask homebrew/cask-versions/firefox-developer-edition
brew install --cask homebrew/cask-versions/google-chrome-beta
brew install --cask kitty
brew install --cask microsoft-teams
brew install --cask visual-studio-code
brew install --cask steam

# install azure dependencies

command -V az && az extension add --name azure-devops

# Remove outdated versions from the cellar.
brew cleanup
