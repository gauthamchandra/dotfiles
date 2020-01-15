#!/usr/bin/env zsh

YELLOW='\033[1;33m'
RED='\033[0;31m'
NO_COLOR='\033[0m'

logInfo() {
  echo -e "${YELLOW}$1${NO_COLOR}"
}

logError() {
  echo -e "${RED}$1${NO_COLOR}"
}

any_local_changes() {
  git diff --quiet HEAD
  return $? 
}

any_conflicts() {
  git status | grep conflict
}

rebase_off_master() {
  logInfo "Checking for any local changes"

  LOCAL_CHANGES=false

  if [[ "$(any_local_changes)" != "0" ]]; then
    LOCAL_CHANGES=true
    
    logInfo "Stashing changes for now..."
    git stash
  fi

  logInfo "Pulling down latest changes for master and rebasing..."
  git fetch && git rebase origin/master  

  logInfo "Installing dependencies"
  npm install

  if [ "$LOCAL_CHANGES" = true ]; then
    logInfo "Restoring the local changes that were stashed..."
    git stash pop
  fi

  FINAL_MSG="Finished with updates"
  if any_conflicts; then
    $FINAL_MSG="There are conflicts after updating"
  fi

  terminal-notifier -message $FINAL_MSG 
}

#=================================
logInfo "Switching to work directory..."
cd $WORK_DIRECTORY

if [ $? != 0 ]; then
  logError "Directory configured in script is invalid"
  exit 1
fi

if [[ "$NO_REBASE" = true ]]; then
  logInfo "\$NO_REBASE=true, skipping pulling changes from master"
else
  rebase_off_master
fi
