#!/usr/bin/env bash

# update path for this session
export PATH="/usr/local/opt/node@12/bin:$PATH"

# Update NPM to the latest version
npm install -g \
  @nrwl/cli \
  eslint \
  eslint-config-prettier \
  eslint-plugin-prettier \
  eslint_d \
  prettier \
  stylelint \
  stylelint-config-standard \
  stylelint-scss \
  typescript

# Clean cache
npm cache clean -f
