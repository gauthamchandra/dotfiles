#!/usr/bin/env bash
set -e
err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}
declare -r execname=.build/debug/$(basename $(pwd))
if [[ -f ${execname} ]]; then
   rm -f ${execname}
fi

declare -r result=$(swift build)
if [[ -z $(swift build) ]]; then
  echo "build success!"
  if    [[ -f ${execname} ]]; then
    echo "running ${execname}"
    echo
    ${execname}
  fi
else
  err "return ${result}"
fi
