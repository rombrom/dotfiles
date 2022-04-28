#!/usr/bin/env bash

# update path for this session
export PATH="/usr/local/opt/node@14/bin:$PATH"

# Update NPM to the latest version
npm install -g \
  eslint@latest \
  eslint-config-prettier@latest \
  eslint-plugin-prettier@latest \
  eslint_d@latest \
  nx \
  prettier@latest \
  stylelint@latest \
  stylelint-config-standard@latest \
  typescript@latest \
  typescript-language-server@latest

# Clean cache
npm cache clean -f
