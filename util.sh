#!/bin/bash

# make sure to exit on error
set -euo pipefail

SETAF_YELLOW=11
SETAF_RED=9
SETAF_BLUE=12

function logWarning() {
  echo "$(tput setaf $SETAF_YELLOW)$1$(tput sgr0)"
}

function logInfo() {
  echo "$(tput setaf $SETAF_BLUE)$1$(tput sgr0)"
}

function logError() {
  echo "$(tput setaf $SETAF_RED)$1$(tput sgr0)"
}

