# Alias hub as git
eval "$(hub alias -s)"

alias gpr='git pull --rebase'
alias gprr='gpr && git submodule update --init --recursive'
alias gd='git diff'
alias gs='git status'
alias gst='git stash'
alias gco='git checkout'
alias gpb='git push -u'

# For finding all my branches that were merged
glist-merged() {
  git for-each-ref --format='%(authorname) %(refname)' --merged | grep 'Gautham Chandra refs/remotes/origin' | awk '{ gsub(/^Gautham Chandra refs\/remotes\/origin\//, ""); print }'
}

# For deleting any local branches that have already been merged on remote
alias gprune-merged='git branch --merged | grep -v -e "master" -e "develop" | xargs -n 1 git branch -d'
