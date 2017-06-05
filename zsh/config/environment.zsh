#Log the command history with the time the command was last executed
export HISTTIMEFORMAT="%F %T "

# Set some useful options
setopt kshglob
setopt extended_glob

# Make aliases available to shell scripts
setopt aliases

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

JAVA_HOME=`/usr/libexec/java_home`

# Add thefuck to shell
eval "$(thefuck --alias)"
