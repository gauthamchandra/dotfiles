#!/bin/bash

# make sure to exit on error
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $SCRIPT_DIR/../util.sh

function install_deps() {
  logInfo "Installing Python and powerline"
  pip3 install --upgrade setuptools
  pip3 install powerline-status
  npm install --global pure-prompt # For the "pure" prompt. See: https://github.com/sindresorhus/pure

  mkdir -p $HOME/bin/

  if [ ! -f $HOME/bin/swiftrun.sh ]; then
    logInfo "Symlinking useful scripts to ~/bin"
    ln -s $SCRIPT_DIR/scripts/swift/swiftrun.sh $HOME/bin/swiftrun.sh
  fi

  logInfo "Downloading and installing powerline appropriate fonts"
  if uname | grep -q "Darwin"; then
    git clone https://github.com/powerline/fonts.git
    cd fonts && ./install.sh && cd .. && rm -rf fonts
  else
    sudo apt install fonts-powerline -y
  fi

  logInfo "Setting the default shell to zsh. You maybe prompted for sudo access"
  chsh -s $(which zsh)
}

function install_zim() {
  logInfo "Installing and configuring zim for a superior Zsh experience"
  (exec $SCRIPT_DIR/install_zim.zsh)
}

function configure_autocompletion() {
  logInfo "Adding entries to $HOME/.zshrc to activate autocompletion"
  
  (tee -a $HOME/.zshrc <<- 'EOF'

# Initialize autocompletion
autoload -Uz compinit

# the .zcompdump files can grow large and slow down zsh init time, don't read from the
# file if it's been longer than 24hrs.
setopt EXTENDEDGLOB
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  for dump in $HOME/.zcompdump(#qN.mh+24); do
    compinit
    if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
      # run zcompile to create compiled files for faster loading
      zcompile "$dump"
    fi
  done
else
  compinit -C
fi
unsetopt EXTENDEDGLOB
EOF
  ) &> /dev/null
}

function configure_autosourcer() {
  logInfo "Adding autosourcer script to $HOME/.zshrc and setting ZSH_CUSTOM_CONFIG var"
  echo -e "\n" >> $HOME/.zshrc
  echo "# === Auto Sourcer ====" >> $HOME/.zshrc
  echo "export ZSH_CUSTOM_CONFIG=$SCRIPT_DIR/config" >> $HOME/.zshrc
  echo "source $SCRIPT_DIR/auto_sourcer.zsh" >> $HOME/.zshrc
  echo -e "\n" >> $HOME/.zshrc
}

function symlink_zimrc() {
  if [ -f "$HOME/.zimrc" ]; then
    echo "~/.zimrc exists already. It was probably installed by the zim installer. Deleting so we can replace with our own"
    rm ~/.zimrc
  fi

  logInfo "Symlinking .zimrc -> ~/.zimrc"
  ln -s $SCRIPT_DIR/.zimrc $HOME/.zimrc
}

# For mac, 'rupa/z' tool is installed automatically when 'brew bundle' is installed.
# As always, Linux requires extra work.
function augment_shell_with_z_plugin_for_linux() {
  if uname | grep -q "Darwin"; then
    logInfo "Assuming OSX and adding Z to ~/.zshrc"
    echo ". $(brew --prefix)/etc/profile.d/z.sh" >> ~/.zshrc
  else
    logInfo "Downloading rupa/z for quick bouncing around into directories"
    mkdir -p ~/shell-scripts
    wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O ~/shell-scripts/z.sh
    echo ". ~/shell-scripts/z.sh" >> ~/.bashrc
    echo ". ~/shell-scripts/z.sh" >> ~/.zshrc
  fi
}

install_deps
install_zim
configure_autocompletion
configure_autosourcer
symlink_zimrc
augment_shell_with_z_plugin_for_linux

logInfo "Adding config to .zshrc"
echo "ZSH_CUSTOM=${SCRIPT_DIR}/config" >> $HOME/.zshrc

logInfo "Adding ~/bin to .zshrc"
echo 'export PATH=$PATH:~/bin' >> $HOME/.zshrc

logInfo "Sourcing file"
source $HOME/.zshrc

logInfo "Running 'zimfw install' for good measure"
zimfw install

logWarning "IMPORTANT: For iTerm2 users, remember to change the font to one of the installed powerline fonts in Preferences!" 
logInfo "Done!"
