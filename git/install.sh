#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Copying git config"
cp ${SCRIPT_DIR}/.gitconfig ~/.gitconfig

echo "Symlinking git config to home directory"
ln -s ${SCRIPT_DIR}/.gitignore_global ~/.gitignore_global

echo "Telling git that"
git config --global core.excludesfile ~/.gitignore_global
