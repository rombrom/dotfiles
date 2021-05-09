#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# prepare taps
brew tap universal-ctags/universal-ctags

# Install core utilities
packages=(
  bat
  bats-core
  coreutils
  dnsmasq
  entr
  findutils
  fzf
  git
  gnu-getopt
  gnu-sed
  gnu-tar
  gnupg
  grep
  jq
  openssh
  pandoc
  ripgrep
  stow
  tmux
  tree
  vim
  wget
  zsh
  zsh-completions
)

# kick-off installation
brew install $packages
unset packages
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# Install Node v12
brew install node@12
brew link node@12 --force --overwrite

# Remove outdated versions from the cellar.
brew cleanup

# TODO: move this?
$(brew --prefix)/opt/fzf/install

# TODO: move this?
chsh -s "$(which zsh)"
