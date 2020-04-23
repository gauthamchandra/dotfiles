#Log the command history with the time the command was last executed
export HISTTIMEFORMAT="%F %T "

# ==== Some Zsh sane defaults (taken from zprezto + some of my own) ======
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
setopt ALIASES             # Make aliases available to shell scripts

if [ "$(uname)" = "Darwin" ]; then
  # Use brew libs over system libs
  export PATH=$PATH:/usr/local/bin

  # Use brew's version of vim if we are on OSX
  alias vim="/usr/local/bin/vim"
fi

# If tmuxinator completion exists, add it to zsh
TMUXINATOR_COMPLETION_FILE=~/.bin/tmuxinator.zsh
if [ -f "$TMUXINATOR_COMPLETION_FILE" ]; then
  source $TMUXINATOR_COMPLETION_FILE 
fi

if command -v nvim >/dev/null 2>&1; then
  alias vim="`which nvim`"
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

export DEFAULT_USER=`whoami`
prompt_context() {}

$(brew --prefix asdf)/asdf.sh

# Set Java home from ASDF
source ~/.asdf/plugins/java/set-java-home.zsh
