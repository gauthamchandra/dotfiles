#!/bin/sh

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
