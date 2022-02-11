#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# prepare taps
brew tap universal-ctags/universal-ctags

# Install core utilities
brew install \
  azure-cli \
  bat \
  bats-core \
  coreutils \
  cmake \
  dnsmasq \
  fd \
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
  jq \
  nmap \
  pandoc \
  postman \
  ripgrep \
  shellcheck \
  stow \
  tree \
  vim \
  watchexec \ # preferred general purpose file watcher
  watchman \  # needed for React Native development...
  wget \
  zsh \
  zsh-completions

brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# Install Node versions
brew install node@12
brew install node@14
brew install node@16

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
  visual-studio-code \ # for pair programming
  steam # daddy needs his Factorio

# install azure dependencies
az extension add --name azure-devops

# Remove outdated versions from the cellar.
brew cleanup
