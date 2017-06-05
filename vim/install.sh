#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NVIM_CONFIG_DIR=~/.config/nvim

echo "Installing neovim"
brew tap neovim/neovim
brew install neovim

echo "Installing python and python3 as required by some neovim plugins"
brew install python
brew install python3

echo "Installing neovim plugins for Ruby and Python"
gem install neovim
pip install neovim
pip3 install neovim

cd $SCRIPT_DIR

echo "Symlinking 'init.vim' => ~/.config/nvim/init.vim"
mkdir -p ${NVIM_CONFIG_DIR} && ln -s `pwd`/init.vim ${NVIM_CONFIG_DIR}/init.vim

echo "Symlinking dir  => ~/.vim/"
ln -s `pwd` ~/.vim

echo "Installing plugin dependencies"
pip install vim-vint

echo "Installing ctags and adding basic config to ~/.ctags"
brew install ctags
ln -s `pwd`/.ctags ~/.ctags

echo "Installing linters so it can be used for vim via neomake"
npm install -g eslint
gem install rubocop

echo "Installing Plugins..."
nvim +PlugInstall +qall

echo "Setting vimrc as executable"
chmod +x vimrc

echo "Done."
echo "Remember to alias vim to nvim!"
