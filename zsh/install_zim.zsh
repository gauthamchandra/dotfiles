#!/bin/zsh

# make sure to exit on error
set -euo pipefail

SCRIPT_DIR="${0:a:h}"
source $SCRIPT_DIR/../util.sh

function install_zim() {
  git clone --recursive https://github.com/zimfw/zimfw.git ${ZDOTDIR:-${HOME}}/.zim
}

function configure_zim() {
  logInfo "Prepending zim init logic to $HOME/.zshrc"
  for template_file in ${ZDOTDIR:-${HOME}}/.zim/templates/*; do
    user_file="${ZDOTDIR:-${HOME}}/.${template_file:t}"
    cat ${template_file} ${user_file}(.N) > ${user_file}.tmp && mv ${user_file}{.tmp,}
  done

  logInfo "Finishing optimization"
  $(source ${ZDOTDIR:-${HOME}}/.zlogin)
}

if [ -d ${ZDOTDIR:-${HOME}}/.zim ]; then
  logWarning "$HOME/.zim directory detected. Zim seems to already be installed. Skipping"
  exit 0
fi

install_zim
configure_zim

logInfo "You can now update zim with: 'zmanage update'"
logInfo "You can remove zim with: 'zmanage remove' (although this command is experimental)"
