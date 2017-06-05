#!/bin/sh
set -e

echo "Installing the command line tools packaged with Xcode"
xcode-select --install

echo "Accepting licenses"
sudo xcodebuild -license accept

echo "Explicitely selecting the correct installation of Xcode to avoid install issues with other deps"
sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

echo "Installing Ag"
brew install the_silver_searcher

echo "Installing JDK"
brew update
brew cask install java

echo "Installing Android SDK"
brew tap caskroom/cask
brew cask install android-sdk

echo "Installing Node and n"
brew install nodejs
npm install -g n

echo "Installing 'reattach-to-user-namespace' to be able to access clipboard in tmux"
brew install reattach-to-user-namespace --wrap-pbcopy-and-pbpaste
