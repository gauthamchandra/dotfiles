# just a quick function to re-source .zshrc
src() {
  source $HOME/.zshrc
}

# For fast searching through files
gcgrep() {
  DEFAULT_SEARCH_DIR=${2:-"*"}
  grep -R -i --exclude "*.log" --binary-files=without-match "$1" $DEFAULT_SEARCH_DIR
}

start_fresh() {
  gpr && bundle && ./yarn.sh && rake db:local:migrate && rake db:seed && rails s
}

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

tmux_layouts() {
  tmux list-windows | sed -n 's/.*layout \(.*\)] @.*/\1/p'
}

alias clear-vim-swaps='ls  ~/.local/share/nvim/swap | grep ".swp" | xargs -I swap_file rm ~/.local/share/nvim/swap/swap_file'
