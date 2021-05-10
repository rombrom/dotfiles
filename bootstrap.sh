#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# Ask for the administrator password upfront
sudo -v;

function main() {
  # Install Homebrew first
  echo "Installing Homebrew...";
  echo "";
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";

  # Install utilities via Homebrew
  echo "Installing Homebrew packages...";
  echo "";
  source ./init/brew.sh;

  # Install essential Node utils
  echo "Installing Node packages...";
  echo "";
  source ./init/node.sh;

  # Sync dotfiles
  echo "Synchronizing dotfiles...";
  echo "";
  stow dotfiles --target="$HOME"

  # Sync settings
  sudo ln -sFi "$(realpath ./settings/dnsmasq.conf)" /usr/local/etc/dnsmasq.conf;
  sudo ln -sFi "$(realpath ./settings/resolver)" /etc/resolver;

  # Kick off dnsmasq
  brew services start dnsmasq

  # change shell to newly installed zsh
  chsh -s "$(which zsh)"

  echo "Done.";
  echo "";
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	main;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ "$REPLY" =~ ^[Yy]$ ]]; then
		main;
	fi;
fi;

unset main;
