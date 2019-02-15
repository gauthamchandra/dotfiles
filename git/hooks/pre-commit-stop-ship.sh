#!/bin/sh

function isStopShipDetected() {
  git diff --staged | grep -q "+.*STOPSHIP"
}

function overrideStopShip() {
  [ ${OVERRIDE_STOPSHIP:-false} = "true" ]
}

if isStopShipDetected && ! overrideStopShip; then
  echo "STOPSHIP detected. Before committing, please remove this code: \n"
  git diff --staged | grep -B 2 -A 2 "+.*STOPSHIP"
  exit 1
fi
