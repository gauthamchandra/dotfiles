#!/bin/sh
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# bring in the utility functions
source $SCRIPT_DIR/../util.sh 

function install_cli_tools() {
  logInfo "Installing Xcode CLI tools"

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
}


function install_brew_and_dependencies() {
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
}

function install_languages_and_tooling() {
  logInfo "Installing Python"
  asdf plugin add python
  asdf install python 3.6.2
  asdf install python 2.7.13
  asdf global python 3.6.2 2.7.13

  logInfo "Installing NodeJS and NPM"
  asdf plugin add nodejs
  bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
  asdf install nodejs 12.19.0
  asdf global nodejs 12.19.0

  logInfo "Installing Ruby"
  asdf plugin add ruby
  asdf install ruby 2.7.1
  asdf global ruby 2.7.1

  touch ~/.bash_profile
  echo "# For ASDF plugin manager" >> ~/.bash_profile
  echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ~/.bash_profile
  echo -e "\n. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash" >> ~/.bash_profile
  echo -e "export PATH=$HOME/.asdf/shims:$PATH" >> ~/.bashrc
}

function install_docker() {
  logInfo "Installing Docker"
  wget https://desktop.docker.com/mac/stable/Docker.dmg -O ~/Downloads/docker.dmg
  local volume=`hdiutil attach ~/Downloads/docker.dmg | grep Volumes | awk '{print $3}'`
  ls -la $volume
  echo cp -rf $volume/*.app /Applications
  cp -rf $volume/*.app /Applications
  hdiutil detach $volume

  open /Applications/Docker/*.app
}

function install_and_configure_alacritty() {
  logInfo "Installing a super performant, GPU accelerated terminal"
  brew install alacritty

  logInfo "Symlinking the alacritty config file over to ~/.alacritty.yml"
  ln -s $SCRIPT_DIR/alacritty.yml ~/.alacritty.yml 
}

install_cli_tools
install_brew_and_dependencies
install_languages_and_tooling
install_docker
install_and_configure_alacritty

logInfo "Be sure to run 'rbenv init' and follow the instructions to setup rbenv"
logInfo "Done"
