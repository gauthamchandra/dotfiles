#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NVIM_CONFIG_DIR=~/.config/nvim

if vim --version | grep -q NVIM; then
  echo "It seems neovim is already installed. Maybe this script was already run?"
  echo "Skipping full installation"
  exit 0
fi

echo "Installing dependencies"
sudo add-apt-repository universe
sudo apt install curl neovim python2 python3 python3-pip ruby ruby-dev -y

# Get python 2
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python2 get-pip.py 

echo "Installing neovim plugins for Ruby and Python"
sudo gem install neovim
pip install neovim
pip3 install neovim

cd $SCRIPT_DIR

echo "Symlinking 'init.vim' => ~/.config/nvim/init.vim"
mkdir -p ${NVIM_CONFIG_DIR} && ln -s `pwd`/init.vim ${NVIM_CONFIG_DIR}/init.vim

echo "Symlinking dir => ~/.vim/"
ln -s `pwd` ~/.vim

echo "Symlinking .vimrc => ~/.vimrc"
chmod +x `pwd`/.vimrc
ln -s `pwd`/.vimrc ~/.vimrc

echo "Installing plugin dependencies"
pip install typing # used for vim-vint
pip install vim-vint
pip install pyyaml
sudo apt install exuberant-ctags -y

echo "Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing Plugins..."
nvim +PlugInstall +UpdateRemotePlugins +qall

echo "Installing Completion Support for Languages"
nvim -c 'CocInstall -sync coc-json coc-tsserver coc-eslint coc-metals|q'

echo "Setting vimrc as executable"
chmod +x .vimrc

echo "Done."
echo "Remember to alias vim to nvim!"
