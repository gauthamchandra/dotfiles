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
pip3 install neovim

cd $SCRIPT_DIR

echo "Symlinking 'init.vim' => ~/.config/nvim/init.vim"
mkdir -p ${NVIM_CONFIG_DIR} && ln -s `pwd`/init.vim ${NVIM_CONFIG_DIR}/init.vim

echo "Symlinking dir => ~/.vim/"
ln -s `pwd` ~/.vim

echo "Symlinking .vimrc => ~/.vimrc"
chmod +x `pwd`/.vimrc
ln -s `pwd`/.vimrc ~/.vimrc

echo "Symlinking xvimrc => ~/.xvimrc (for Xcode)"
chmod +x `pwd`/.xvimrc
ln -s `pwd`/.xvimrc ~/.xvimrc

echo "Symlinking ideavimrc => ~/.ideavimrc (for IntelliJ)"
chmod +x `pwd`/.ideavimrc
ln -s `pwd`/.ideavimrc ~/.ideavimrc

echo "Installing plugin dependencies"
pip3 install typing # used for vim-vint
pip3 install vim-vint
brew install sourcekitten # used for autocomplete-swift
pip3 install pyyaml

echo "Installing ctags and adding basic config to ~/.ctags"
brew install ctags
ln -s `pwd`/.ctags ~/.ctags

echo "Installing linters so it can be used for vim via neomake"
npm install -g eslint
gem install rubocop
gem install solargraph
brew install swiftlint

echo "Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing Plugins..."
nvim +PlugInstall +UpdateRemotePlugins +qall

echo "Installing Completion Support for Languages"
nvim -c 'CocInstall -sync coc-json coc-tsserver coc-eslint coc-metals coc-solargraph|q'

echo "Setting vimrc as executable"
chmod +x .vimrc

echo "Done."
echo "Remember to alias vim to nvim!"
