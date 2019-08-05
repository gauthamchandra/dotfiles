#!/bin/sh
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# bring in the utility functions
source $SCRIPT_DIR/util.sh 

if xcode-select -p; then
  logInfo "Command line tools already installed. Skipping"
else
  logInfo "Installing the command line tools packaged with Xcode"
  xcode-select --install
fi

logInfo "Accepting licenses"
sudo xcodebuild -license accept

logInfo "Explicitely selecting the correct installation of Xcode to avoid install issues with other deps"
sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

if which brew; then
  logInfo "Brew installed. Skipping installation"
else
  logInfo "Brew not detected. Installing Homebrew"
  # taken from the brew.sh site
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

if [ ! -f $HOME/Brewfile ]; then
  logInfo "Copying over the Brewfile to $HOME"
  ln -s $SCRIPT_DIR/Brewfile $HOME/Brewfile
fi

logInfo "Installing all brew dependencies..."
cd $HOME && brew bundle

logInfo "Be sure to run 'rbenv init' and follow the instructions to setup rbenv"
logInfo "Done"
