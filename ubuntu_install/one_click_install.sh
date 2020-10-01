#!/bin/bash

# make sure to exit on error
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $SCRIPT_DIR/../util.sh

function install_and_configure_zsh() {
  ( exec $SCRIPT_DIR/../zsh/install.sh )
}

function install_and_configure_git() {
  ( exec $SCRIPT_DIR/../git/install.sh )
}

function install_and_configure_vim() {
  ( exec $SCRIPT_DIR/../vim/install_ubuntu.sh )
}

function install_core_deps() {
  logInfo "Adding necessary repositories"
  sudo add-apt-repository ppa:mmstick76/alacritty -y
  sudo apt update

  logInfo "Setting hardware clock to local time (instead of UTC for supporting Dual boots with Windows)"
  timedatectl set-local-rtc 1
}

function install_development_deps() {
  echo "Installing a MUCH better, more performant terminal" 
  logInfo apt install xdotool alacritty -y

  logInfo "Symlinking a basic alacritty config to ~/.config"
  mkdir -p ~/.config && ln -s $SCRIPT_DIR/alacritty.yml ~/.config/alacritty.yml

  logInfo "Installing rbenv and specifying Ruby version 2.7.1 as the default"
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
  rbenv global 2.7.1

  logInfo "Installing all necessary dev tools for day-to-day work"
  sudo apt install zsh hub tmux tree silversearcher-ag fzf awscli redis fzf -y
  sudo snap install --classic heroku

  # Install a unified plugin manager 
  logInfo "Installing ASDF Plugin Manager"
  if [ -d ~/.asdf ]; then
    logInfo "ASDF installation found. Skipping."
  else
    logInfo "Installing ASDF and exporting binary to ~/.zshrc"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
    
    cd ~/.asdf
    git checkout "$(git describe --abbrev=0 --tags)"
    echo "export PATH=$PATH:~/.asdf/bin/asdf" >> $HOME/.zshrc
  fi

  logInfo "Installing NodeJS Plugin for development"
  asdf plugin add nodejs
}

function install_core_apps() {
  sudo snap install spotify  
}


install_core_deps
install_core_apps
install_development_deps
install_and_configure_zsh
install_and_configure_git
install_and_configure_vim

logInfo "Installation Complete! Reloading shell via autosourcer"
src
