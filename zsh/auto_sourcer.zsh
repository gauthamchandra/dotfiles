#!/bin/zsh

# This is sort of the Zsh equivalent of Vim's `~/.vim/plugin` directory. It's sole job is
# to source all the files in `config/` so that all our custom config, aliases and env vars
# we setup in a separate dir just work.
#
# It will automatically find and source all files in the directory

SCRIPT_DIR="${0:a:h}"

if (( ! ${+ZSH_CUSTOM_CONFIG} )); then
  echo "No Zsh custom directory set. Skipping initialization"
  exit 0
fi

for f in $ZSH_CUSTOM_CONFIG/**/*.zsh; do
  source $f
done
