# For fast searching through files
gcgrep() {
  DEFAULT_SEARCH_DIR=${2:-"*"}
  grep -R -i --exclude "*.log" --binary-files=without-match "$1" $DEFAULT_SEARCH_DIR
}

#Zeus for preloading parts of the app for faster rspec tests
ze () { ARGS=$@; zeus $@; ZE_EC=$?; stty sane; if [ $ZE_EC = 2 ]; then ze $ARGS; fi } 

# Retries a command a specified number of times but stops early if
# it succeeds
retry () {
  COMMAND=$1
  RETRIES=$2
  PAUSE_INTERVAL=$3

  if [ -z $RETRIES ]; then
    RETRIES=1
  fi

  for i in {1..$RETRIES}; do eval $COMMAND && break || sleep $PAUSE_INTERVAL; done
}

# Retries a command a specified number of times
repeat_command() {
  COMMAND=$1
  RETRIES=$2
  PAUSE_INTERVAL=$3

  if [ -z $RETRIES ]; then
    RETRIES=1
  fi

  for i in {1..$RETRIES}; do eval $COMMAND; sleep $PAUSE_INTERVAL; done
}

alias clear-vim-swaps='find ./ -type f -name "\.*sw[klmnop]" -delete'
