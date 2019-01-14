# Polls until a command returns a value other than the value specified
poll_command_until_value_change() {
  COMMAND=$1
  VALUE=$2

  local output=$(eval $COMMAND)

  while [[ $output == $VALUE ]]; do
    sleep 30s # don't query nonstop, wait and query in intervals
    output=$(eval $COMMAND)
  done

  echo $output
}

poll_for_ci_status() {
  BRANCH=$1

  echo "Beginning polling for $BRANCH"

  local commit=$(git rev-parse $BRANCH)

  # hub ci-status returns one of the following:
  # success (0), error (1), failure (1), pending (2), no status (3)
  local result=$(poll_command_until_value_change "hub ci-status $commit" "pending")

  if [[ $result == "success" ]]; then
    terminal-notifier -message "PASS: CI for $BRANCH"
  else
    terminal-notifier -message "FAILED: CI for $BRANCH"
  fi
}
