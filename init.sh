#!/usr/bin/env bash

# Install Homebrew first
if ! type "brew" 2>/dev/null; then
  echo "Installing Homebrew..."
  echo ""
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make brew available
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install utilities via Homebrew
echo "Installing Homebrew packages..."
echo ""
source ./init/brew.sh

# Sync dotfiles
echo "Synchronizing dotfiles..."
echo ""
stow --dir=dotfiles --target="$HOME" \
  --stow ctags \
  --stow git \
  --stow kitty \
  --stow misc \
  --stow vim \
  --stow zsh \
  --verbose


# Install essential Node utils
echo "Installing Node packages..."
echo ""
source ./init/node.sh

# Install fun bun
curl https://bun.sh/install | bash

# Install essential Python utils
#echo "Installing Python packages..."
#echo ""
#source ./init/python.sh

# Generate zsh completions
echo "Getting zsh completions"
COMPLETIONS=./dotfiles/zsh/.config/zsh/completions
curl -L \
  https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/_docker \
  > $COMPLETIONS/_docker
curl -L \
  https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose \
  > $COMPLETIONS/_docker-compose

echo "Installing vim plugins"
echo ""
vim +PlugInstall +qa

# Sync settings
echo "Copying settings..."
echo ""
cp -v ./settings/dnsmasq.conf $HOMEBREW_PREFIX/etc/dnsmasq.conf

sudo mkdir -p /etc/resolver
sudo cp -v ./settings/localhost.resolver /etc/resolver/localhost

# Kick off dnsmasq
sudo brew services start dnsmasq

# change shell to newly installed zsh
echo "Changing shell to /usr/local/bin/zsh"
echo ""
sudo chsh -s "$(command -v zsh)" "$(whoami)"
