#!/usr/bin/env bash

OLDPWD="$PWD"
cd "$HOME" || exit

# Update NPM to the latest version
npm install

cd "$OLDPWD" || exit
