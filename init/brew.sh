#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
# Install zsh
brew install zsh zsh-completions

# Switch to using brew-installed zsh as default shell
chsh -s "$(which zsh)"

# Install `wget` with IRI support.
brew install wget

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim
brew install grep
brew install openssh

# Install other useful binaries.
brew install bats-core
brew install composer
brew install dnsmasq
brew install entr
brew install git
brew install jq
brew install node@12
brew install pandoc
brew install tmux
brew install tree
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# Install fuzzyfinder and setup fuzzy completion
brew install fzf
brew install ripgrep
$(brew --prefix)/opt/fzf/install

# Rest; helpers for coding etc.
brew install php-cs-fixer

# Remove outdated versions from the cellar.
brew cleanup
