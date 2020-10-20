#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $SCRIPT_DIR

echo "Installing tmuxinator"
gem install tmuxinator

echo "Downloading muxinator completion file for zsh"
wget --no-check-certificate "https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh"
mkdir -p ~/.bin && mv tmuxinator.zsh ~/.bin/tmuxinator.zsh

echo "Adding a setup script used by the muxinator config to the proper place"
mkdir -p ~/development/setup-scripts && ln -s `pwd`/pull-down-work-changes.sh ~/development/setup-scripts/pull-down-work-changes.sh 

echo "Symlinking the tmuxinator files to home directory"
ln -s `pwd`/.tmuxinator ~/.tmuxinator

echo "Downloading tmux plugin manager to ~/.tmux/plugins/tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Symlinking the tmux and powerline config over to home directory"
ln -s `pwd`/.tmux.conf ~/.tmux.conf
ln -s `pwd`/.tmux-status-bar.conf ~/.tmux-status-bar.conf
