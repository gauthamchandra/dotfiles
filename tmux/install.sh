#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $SCRIPT_DIR

echo "Installing tmux"
brew install tmux

echo "Installing tmuxinator"
gem install tmuxinator

echo "Downloading muxinator completion file for zsh"
wget "https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh"
mkdir -p ~/.bin && mv tmuxinator.zsh ~/.bin/tmuxinator.zsh

echo "Adding a setup script used by the muxinator config to the proper place"
mkdir -p ~/development/setup-scripts && ln -s pull-down-work-changes.sh ~/development/setup-scripts/pull-down-work-changes.sh 

echo "Symlinking the tmuxinator files to home directory"
ln -s .tmuxinator ~/.tmuxinator
