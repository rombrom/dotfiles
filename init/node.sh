#!/usr/bin/env bash

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
