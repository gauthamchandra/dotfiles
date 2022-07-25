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

  if [ ! -f "$(brew --prefix)/etc/openssl@1.1/certs/cacerts.pem" ]; then
    logInfo 'Ensuring the path to the "cacerts.pem" file is set as an ENV var for openssl to find'
    ln -s `brew --prefix`/etc/openssl@1.1/cert.pem `brew --prefix`/etc/openssl@1.1/certs/cacerts.pem
    `brew --prefix openssl@1.1`/bin/c_rehash
  fi

  echo "\n# Ensure OpenSSL and any dependent libraries pick up the cacerts.pem file" >> ~/.zshrc
  echo "export SSL_CERT_FILE=$(brew --prefix)/etc/openssl@1.1/cert.pem" >> ~/.zshrc
}


function install_m1_specific_tools_if_detected() {
  if uname -p | grep -q arm; then
    logInfo "M1 Mac Detected. Beginning installation of core libraries needed for development"
    logInfo "Installing Rosetta 2 for emulating x86 only binaries via the 'arch' command"
    sudo softwareupdate --install-rosetta --agree-to-license

    logInfo "Installing gettext as it is bundled with 'old' x86 homebrew but not ARM homebrew"
    brew install gettext

    logInfo "Installing core binaries like openssl so they don't botch installs like ruby later on"
    brew update
    brew install -s readline openssl ruby-build
    brew upgrade ruby-build

    logInfo "Downgrading to an older version of openssl so ruby-build can succeed (due to compatibility differences)"
    brew install openssl@1.1 && brew unlink openssl && brew link openssl@1.1 --force

    logInfo "Setting LDFLAGS, CPPFLAGS and optflags to point to homebrew"
    cat <<- 'EOF' >> ~/.zshrc
    # Setting LDFLAGS, CPPFLAGS and optflags to point to homebrew
    export LDFLAGS="-L/opt/homebrew/lib"
    export CPPFLAGS="-I/opt/homebrew/include"
    export optflags="-Wno-error=implicit-function-declaration"
EOF

    logInfo "Setting PYTHON_CONFIGURE_OPTS to build the 'universal' version when installing"
    cat <<- 'EOF' >> ~/.zshrc

    # Setting PYTHON_CONFIGURE_OPTS to build the 'universal' version when installing
    export PYTHON_CONFIGURE_OPTS="--enable-framework --enable-universalsdk --with-universal-archs=universal2"
EOF

    logInfo "Setting RUBY_CONFIGURE_OPTS to point to Homebrew's version of openssl"
    cat <<- 'EOF' >> ~/.zshrc

    # Setting RUBY_CONFIGURE_OPTS to point to Homebrew's version of openssl
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1) --with-opt-dir=$(brew --prefix readline) --without-tcl --without-tk"
EOF

    logInfo "Also setting CFLAGS to handle implicit funcs for ruby versions < 3.0 that don't have implicit M1 support"
    cat <<- 'EOF' >> ~/.zshrc

    export CFLAGS="-Wno-error=implicit-function-declaration -w"
    export PKG_CONFIG_PATH=$(brew --prefix openssl@1.1)/lib/pkgconfig
EOF

    # Now source zshrc for good measure
    source ~/.zshrc
  fi
}


function install_languages_and_tooling() {
  logInfo "Installing Python"
  (asdf plugin list | grep -q python) || asdf plugin add python
  asdf install python 3.10.4
  asdf global python 3.10.4

  logInfo "Installing NodeJS and NPM"
  (asdf plugin list | grep -q nodejs) || asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf install nodejs 16.15.0 
  asdf global nodejs 16.15.0 

  logInfo "Installing yarn"
  npm install -g yarn

  logInfo "Installing Ruby"
  (asdf plugin list | grep -q ruby) || asdf plugin add ruby 
  asdf install ruby 2.7.1
  asdf global ruby 2.7.1

  touch ~/.zshrc
  echo '# For ASDF plugin manager' >> ~/.zshrc
  echo "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
  echo "export PATH=$HOME/.asdf/shims:$PATH" >> ~/.zshrc

  # not sure why but recent installs of asdf don't actually make the asdf script executable. Probably a bug
  chmod a+x $(brew --prefix asdf)/libexec/asdf.sh
}

function install_docker() {
  logInfo "Installing Docker"

  if uname -p | grep -q arm; then
    echo "Downloading Docker for Mac (M1 edition)"
    wget 'https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64' -O ~/Downloads/docker.dmg 
  else
    echo "Downloading Docker for Mac (Intel edition)"
    wget https://desktop.docker.com/mac/stable/Docker.dmg -O ~/Downloads/docker.dmg  
  fi
  
  local volume=`hdiutil attach ~/Downloads/docker.dmg | grep Volumes | awk '{print $3}'`
  echo cp -rf $volume/*.app /Applications
  cp -rf $volume/*.app /Applications
  hdiutil detach $volume

  open /Applications/Docker.app
}

function install_and_configure_alacritty() {
  logInfo "Installing a super performant, GPU accelerated terminal"
  brew install alacritty

  logInfo "Symlinking the alacritty config file over to ~/.alacritty.yml"
  ln -s $SCRIPT_DIR/alacritty.yml ~/.alacritty.yml 
}

install_cli_tools
install_m1_specific_tools_if_detected
install_brew_and_dependencies
install_languages_and_tooling
install_docker
install_and_configure_alacritty

logInfo "Done"
