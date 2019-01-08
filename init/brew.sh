#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

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

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh

# Install other useful binaries.
brew install ansible
brew install composer
brew install dnsmasq
brew install git
brew install gnupg
brew install kubectx
brew install kubernetes-helm
brew install node
brew install the_silver_searcher
brew install terraform
brew install tmux
brew install tree

# Remove outdated versions from the cellar.
brew cleanup
