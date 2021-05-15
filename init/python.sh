#!/usr/bin/env bash

# update path for this session
export PATH="/usr/local/opt/python@3.9/libexec/bin:$PATH"

pip install 'python-language-server[all]'
pip install autoimport
pip install black
pip install isort
pip install mypy
pip install pipenv
