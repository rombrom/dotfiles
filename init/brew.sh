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
brew install gnu-sed --with-default-names
# Install zsh
brew install zsh zsh-completions

# Switch to using brew-installed zsh as default shell
chsh -s "$(which zsh)"

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh

# Install other useful binaries.
brew install composer
brew install dnsmasq
brew install git
brew install jq
brew install kubectx
brew install node
brew install terraform
brew install tmux
brew install tree

# Install fuzzyfinder and setup fuzzy completion
brew install fzf
brew install ripgrep
$(brew --prefix)/opt/fzf/install

# Rest; helpers for coding etc.
brew install php-cs-fixer

# Remove outdated versions from the cellar.
brew cleanup
