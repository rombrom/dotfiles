#!/usr/bin/env bash

# Update NPM to the latest version
packages=(
  # base packages
  eslint
  eslint_d
  nx
  prettier
  stylelint
  typescript

  # linting add-ons
  eslint-config-prettier
  eslint-plugin-prettier
  stylelint-config-standard
  stylelint-scss
)
npm install -g $packages

# Clean cache
npm cache clean -f
