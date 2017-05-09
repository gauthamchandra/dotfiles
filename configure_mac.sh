#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MAXFILES_PLIST_LOCATION=/Library/LaunchDaemons/limit.maxfiles.plist
MAXPROC_PLIST_LOCATION=/Library/LaunchDaemons/limit.maxproc.plist

echo "Configuring Finder to show all files (including hidden)"
defaults write com.apple.finder AppleShowAllFiles YES

echo "Raising open file and proc limits by changing plist config"

if sudo test -f $MAXFILES_PLIST_LOCATION; then
  echo "file already exists! Skipping copy" 
  sudo launchctl unload $MAXFILES_PLIST_LOCATION 
else
  sudo cp $SCRIPT_DIR/limit.maxfiles.plist $MAXFILES_PLIST_LOCATION 
  sudo chown -R root:wheel $MAXFILES_PLIST_LOCATION 
  sudo launchctl load $MAXFILES_PLIST_LOCATION 
fi

if sudo test -f $MAXPROC_PLIST_LOCATION; then
  echo "file already exists! Skipping copy" 
  sudo launchctl unload $MAXPROC_PLIST_LOCATION 
else
  sudo cp $SCRIPT_DIR/limit.maxproc.plist $MAXPROC_PLIST_LOCATION 
  sudo chown -R root:wheel $MAXPROC_PLIST_LOCATION 
  sudo launchctl load /Library $MAXPROC_PLIST_LOCATION
fi
