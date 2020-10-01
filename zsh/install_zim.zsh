#!/bin/zsh

# make sure to exit on error
set -euo pipefail

setopt EXTENDED_GLOB

SCRIPT_DIR="${0:a:h}"
source $SCRIPT_DIR/../util.sh

function install_zim() {
  curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
}

if [ -d ${ZDOTDIR:-${HOME}}/.zim ]; then
  logWarning "$HOME/.zim directory detected. Zim seems to already be installed. Skipping"
  exit 0
fi

install_zim
