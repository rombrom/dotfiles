#!/usr/bin/env bash

# Update NPM to the latest version
npm install -g npm

# Install useful binaries
npm install -g \
  eslint \
  prettier \
  stylelint \
  typescript

# Install add-ons for eslint
npm i -g \
  eslint-config-prettier \
  eslint-plugin-prettier \
  eslint-plugin-svelte3 \
  prettier-plugin-svelte \
  stylelint-config-standard \
  stylelint-scss

# Clean cache
npm cache clean -f
