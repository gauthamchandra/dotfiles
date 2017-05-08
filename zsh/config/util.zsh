# For fast searching through files
gcgrep() {
  DEFAULT_SEARCH_DIR=${2:-"*"}
  grep -R -i --exclude "*.log" --binary-files=without-match "$1" $DEFAULT_SEARCH_DIR
}

#Zeus for preloading parts of the app for faster rspec tests
ze () { ARGS=$@; zeus $@; ZE_EC=$?; stty sane; if [ $ZE_EC = 2 ]; then ze $ARGS; fi } 

alias clear-vim-swaps='find ./ -type f -name "\.*sw[klmnop]" -delete'
