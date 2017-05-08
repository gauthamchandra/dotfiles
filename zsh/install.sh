#!/bin/bash

# make sure to exit on error
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing Python and powerline"
brew install python
pip install --upgrade pip setuptools
pip install powerline-status

echo "Installing external zsh plugin dependencies"
pip install thefuck
brew install git hub jump

echo "Downloading and installing powerline appropriate fonts for the `agnoster` theme"
git clone https://github.com/powerline/fonts.git
cd fonts && ./install.sh && cd .. && rm -rf fonts

echo "Adding config to .zshrc"
echo "ZSH_CUSTOM=${SCRIPT_DIR}/config" >> ~/.zshrc

echo "Sourcing file"
source ~/.zshrc

echo "IMPORTANT: For iTerm2 users, remember to change the font to one of the installed powerline fonts in Preferences!" 
echo "Done!"
