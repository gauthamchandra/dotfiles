#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $SCRIPT_DIR/../util.sh

logInfo "To configure your git user info, please enter the following:"
read -p "First Name:" FIRST_NAME
read -p "Last Name:" LAST_NAME
read -p "Email:" EMAIL
git config --global user.name "$FIRST_NAME $LAST_NAME"
git config --global user.email $EMAIL

logInfo "Copying git config"
cp ${SCRIPT_DIR}/.gitconfig ~/.gitconfig

logInfo "Symlinking git config to home directory"
ln -s ${SCRIPT_DIR}/.gitignore_global ~/.gitignore_global

logInfo "Telling git that"
git config --global core.excludesfile ~/.gitignore_global

logInfo "Set default global commit hooks to our hooks dir"
git config --global core.hooksPath $SCRIPT_DIR/hooks/

logInfo "Forcing git to actually store the credentials so it doesn't keep asking for it"
git config --global credential.helper store
