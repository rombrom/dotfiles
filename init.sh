#!/usr/bin/env bash

# Install Homebrew first
if ! type "brew" 2>/dev/null; then
  echo "Installing Homebrew..."
  echo ""
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make brew available
if command -V /usr/local/bin/brew; then
  /usr/local/bin/brew shellenv >> "$HOME/.zprofile"
  eval "$(/usr/local/bin/brew shellenv)"
elif command -V /opt/homebrew/bin/brew; then
  /opt/homebrew/bin/brew shellenv >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install utilities via Homebrew
echo "Installing Homebrew packages..."
echo ""
source ./init/brew.sh

# Install mise stuff
echo "Installing mise tooling"
echo ""
mise install
corepack enable
# lots of projects use yarn v1 still...
corepack prepare yarn@1 --activate
mise reshim

# Sync dotfiles
echo "Synchronizing dotfiles..."
echo ""
stow --dir=dotfiles --target="$HOME" \
  --stow ctags \
  --stow git \
  --stow hammerspoon \
  --stow kitty \
  --stow misc \
  --stow mise \
  --stow neovim \
  --stow vim \
  --stow zsh \
  --verbose


# Install essential Node utils
echo "Installing Node packages..."
echo ""
source ./init/node.sh

# Foundry
# TODO
curl -L https://foundry.paradigm.xyz | bash
$HOME/.foundry/bin/foundryup

# Rust
rustup-init
rustup component add rust-analyzer

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
vim +"Lazy install" +qa

# Sync settings
echo "Copying settings..."
echo ""
cp -v ./settings/dnsmasq.conf $HOMEBREW_PREFIX/etc/dnsmasq.conf

sudo mkdir -p /etc/resolver
sudo cp -v ./setting/localhost.resolver /etc/resolver/localhost

# Kick off dnsmasq
sudo brew services start dnsmasq

# change shell to newly installed zsh
echo "Changing shell to /usr/local/bin/zsh"
echo ""
sudo chsh -s "$(command -v zsh)" "$(whoami)"
