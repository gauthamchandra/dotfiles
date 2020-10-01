#!/bin/bash

# make sure to exit on error
set -euo pipefail

PID=$(pgrep alacritty)
if [ -z "$PID" ]; then
  # Its not running, so just run it.
  alacritty
  exit 0
else
  # If it is launched then check if it is focused
  foc=$(xdotool getactivewindow getwindowpid)

  if [[ $PID == $foc ]]; then
    # if it is focused, then minimize
    xdotool getactivewindow windowminimize
  else
    # if it isn't focused then get focus
    wmctrl -x -R alacritty
  fi
fi
