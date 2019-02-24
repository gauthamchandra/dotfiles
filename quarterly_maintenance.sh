#!/bin/sh
set -euo pipefail

function isUpdateAvailableForBrewPackage() {
  brew outdated | grep -q $1
}

echo "Fetching updates for brew..."
brew update

declare -a core_packages=(
'neovim'
'git'
'python'
'python2'
'awscli'
'redis'
'tree'
'tmux'
'wget'
'hub'
'the_silver_searcher'
)

echo "Checking and upgrading core packages needed for daily development"
for packageName in "${core_packages[@]}"; do
  if isUpdateAvailableForBrewPackage $packageName; then
    echo "Upgrading $packageName"
    brew upgrade $packageName 
  fi
done

echo "Ensuring all neovim compatible language adapters are installed"
pip install -U neovim
pip3 install -U neovim
gem install neovim

echo "Upgrading vim-plug, any other vim dependencies and doing some cleanup..."
vim +PlugUpgrade +PlugInstall +UpdateRemotePlugins +PlugUpdate +PlugClean +qa

echo "Updating terminal-notifier"
gem install terminal-notifier

echo "Restarting affected services"
brew services restart redis

echo "Doing some cleanup"
brew cleanup

echo "Done!" && terminal-notifier -message "Complete!"
