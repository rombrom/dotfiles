#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# prepare taps
brew tap universal-ctags/universal-ctags

# Install core utilities
brew install \
  bat \
  bats-core \
  coreutils \
  dnsmasq \
  entr \
  findutils \
  fzf \
  gawk \
  ghostscript \
  git \
  gnu-getopt \
  gnu-sed \
  gnu-tar \
  grep \
  imagemagick \
  pandoc \
  ripgrep \
  stow \
  tree \
  vim \
  wget \
  zsh \
  zsh-completions

brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# Install Node v12
brew install node@12

# Install Recent Python
brew install python

# fix zsh-completion directory permissions
chmod -R go-w '/usr/local/share/zsh'

# install casks
brew install --casks \
  1password \
  appcleaner \
  docker \
  firefox-developer-edition \
  google-chrome \
  kitty \
  microsoft-teams \
  spotify

# Remove outdated versions from the cellar.
brew cleanup
