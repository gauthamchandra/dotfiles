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
  # Disable error handling temporarily to fix the issue with rbenv script trying to run verifications and erroring before 'rbenv init' can be run
  set +euo pipefail

  logInfo "Installing rbenv and specifying Ruby version 2.7.1 as the default"
  export PATH=$PATH:~/.rbenv/bin # set this explicitly so rbenv verification passes. This is already zsh config
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
  rbenv init
  rbenv global 2.7.1
  rbenv install 2.7.1
  
  set -euo pipefail

  logInfo "Installing docker"
  sudo apt install apt-transport-https ca-certificates gnupg-agent software-properties-common -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
  sudo apt update
  sudo apt install docker-ce docker-ce-cli containerd.io -y
  docker -v

  logInfo "Installing docker-compose"
  sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  logInfo "Setting up docker so that it can be run as a non-root user"
  sudo usermod -aG docker ${USER}
  logWarning "User '${USER}' has been added to the docker group 'docker'. For changes to take effect, please log out and log back in!"
  sudo systemctl restart docker

  logInfo "Installing all necessary dev tools for day-to-day work"
  sudo apt install zsh hub tmux tree silversearcher-ag fzf awscli redis fzf xbindkeys libpq-dev zeal -y
  sudo snap install --classic heroku
  sudo snap install postman

  logInfo "Installing a MUCH better, more performant terminal" 
  sudo apt install xdotool wmctrl alacritty -y

  logInfo "Symlinking a basic alacritty config to ~/.config"
  mkdir -p ~/.config && ln -s $SCRIPT_DIR/alacritty.yml ~/.config/alacritty.yml
  
  logInfo "Symlinking hotkey config (./.xbindkeysrc -> ~/.xbindkeysrc)"
  ln -s $SCRIPT_DIR/.xbindkeysrc ~/.xbindkeysrc
  mkdir -p ~/shell-scripts
  ln -s $SCRIPT_DIR/toggle_alacritty_with_hotkey.sh ~/shell-scripts/toggle_alacritty_with_hotkey.sh

  logInfo "Ensuring xbindkeys starts up on login so custom hotkeys work as intended"
  touch ~/.xsessionrc
  echo "# Starts up Xbindkeys for custom hotkeys" >> ~/.xsessionrc
  echo "xbindkeys" >> ~/.xsessionrc

  # Install a unified plugin manager 
  logInfo "Installing ASDF Plugin Manager"
  if [ -d ~/.asdf ]; then
    logInfo "ASDF installation found. Skipping."
  else
    logInfo "Installing ASDF and exporting binary to ~/.zshrc"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
    
    cd ~/.asdf
    git checkout "$(git describe --abbrev=0 --tags)"
    echo "# Adding ASDF plugin manager to path"
    echo "export PATH=$PATH:~/.asdf/bin/asdf" >> ~/.bashrc
    echo "export PATH=$PATH:~/.asdf/bin/asdf" >> ~/.zshrc
  fi

  logInfo "Installing NodeJS Plugin for development and configuring installation of modules to ~/.npm-global"
  asdf plugin add nodejs
  mkdir -p ~/.npm-global
  npm config set prefix '~/.npm-global'
}

function install_core_apps() {
  sudo snap install spotify libreoffice inkscape
  sudo snap install slack --classic
  sudo apt install gpick gparted -y
}

install_core_deps
install_core_apps
install_development_deps
install_and_configure_zsh
install_and_configure_git
install_and_configure_vim

logWarning "Please upgrade the kernel (using something like Ukuu to fix hardware driver issues like non-cold booting back from windows)!"
logWarning "Not doing so will result in camera hardware (like IR) or Bluetooth from not working reliably in some cases!"
logInfo "Installation Complete! Reloading shell via autosourcer"
src
