#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

function main() {
  # Install Homebrew first
  echo "Installing Homebrew..."
  echo ""
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Install utilities via Homebrew
  echo "Installing Homebrew packages..."
  echo ""
  source ./init/brew.sh

  # Install essential Node utils
  echo "Installing Node packages..."
  echo ""
  source ./init/node.sh

  # Install essential Node utils
  echo "Installing Python packages..."
  echo ""
  source ./init/python.sh

  # Sync dotfiles
  echo "Synchronizing dotfiles..."
  echo ""
  stow dotfiles --dotfiles --target="$HOME"

  # Sync settings
  sudo ln -sFi "$(realpath ./settings/dnsmasq.conf)" /usr/local/etc/dnsmasq.conf
  sudo ln -sFi "$(realpath ./settings/resolver)" /etc/resolver

  # Kick off dnsmasq
  brew services start dnsmasq

  # change shell to newly installed zsh
  echo "Done after changing shell"
  echo ""
  chsh -s "/usr/local/bin/zsh"
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	main
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo ""
	if [[ "$REPLY" =~ ^[Yy]$ ]]; then
		main
	fi
fi

unset main
