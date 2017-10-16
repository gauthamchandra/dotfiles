# Ruby

# Initialize rbenv
eval "$(rbenv init -)"

# General Rails stuff
alias rspec="bundle exec rspec"
alias rake="bundle exec rake"

# Some useful aliases
alias rlint="git diff --name-only | grep -G '.*\.rb' |  xargs rubocop"

export UNICORN_TIMEOUT=10000000000000;
export UNICORN_WORKERS=3;
export DB_POOL=25
