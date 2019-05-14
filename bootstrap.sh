#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

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

  # Install oh-my-zsh
  echo "Installing Oh My ZSH!...";
  echo "";
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";

  # Add zsh scripts to oh-my-zsh custom directory
  echo "Synchronizing Oh My ZSH Custom folder"
  echo ""
  for f in ./zsh/*; do
    local name="$(basename $f)";
    local src="$(realpath $f)";
    local dest="~/.oh-my-zsh/custom/$name";

    ln -sFi "$src" "$dest";
  done;

  # Sync dotfiles
  echo "Synchronizing dotfiles...";
  echo "";
  for f in ./dotfiles/.*; do
    local name="$(basename $f)";
    local src="$(realpath $f)";
    local dest="~/$name";

    if [[ -d "$name" ]] && [[ "$name" = ".vim" ]]; then
      cp -fir "$src" "$dest";
    else
      ln -sFi "$path" "$dest";
    fi
  done;

  # Sync settings
  ln -sFi "$(realpath ./settings/dnsmasq.conf)" /usr/local/etc/dnsmasq.conf;
  ln -sFi "$(realpath ./settings/resolver)" /etc/resolver;

  # Kick off dnsmasq
  brew services start dnsmasq

  # Execute macos defaults
  echo "Setting mac defaults";
  echo "";
  source ./init/macos.sh

  echo "Done.";
  echo "";
}

# Make italics work in macOS terminal
tic -o "$HOME/.terminfo" ./terminfo/tmux.terminfo
tic -o "$HOME/.terminfo" ./terminfo/tmux-256color.terminfo
tic -o "$HOME/.terminfo" ./terminfo/xterm-256color.terminfo

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
