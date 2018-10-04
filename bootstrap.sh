#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
  # Install Homebrew first
  echo "Installing Homebrew...";
  echo "";
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";

  # Install utilities via Homebrew
  echo "Installing Homebrew packages...";
  echo "";
  source ./init/brew.sh

  # Install essential Node utils
  echo "Installing Node packages...";
  echo "";
  source ./init/node.sh

  # Install oh-my-zsh
  echo "Installing Oh My ZSH!...";
  echo "";
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  # Add zsh scripts to oh-my-zsh custom directory
  echo "Synchronizing Oh My ZSH Custom folder"
  echo ""
  rsync -avh --no-perms ./zsh ~/.oh-my-zsh/custom

  # Sync dotfiles
  echo "Synchronizing dotfiles...";
  echo "";
	rsync -avh --no-perms ./dotfiles ~;

  # Sync settings
  cp ./settings/vscode.json ~/Library/Application Support/Code/User/settings.json

  # Execute macos defaults
  echo "Setting mac defaults";
  echo "";
  source ./init/macos.sh

  echo "Done.";
  echo "";
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;