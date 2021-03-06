# Alias lab as git which is a wrapper for both hub (github) and git
# and adds gitlab features in a nice CLI.
#alias git=lab
#
# For the foreseeable future, I will be using Github again (thank god). So not going to wrap git with lab. Will use hub instead.
alias git=hub

alias gpr='git pull --rebase'
alias gprr='gpr && git submodule update --init --recursive'
alias gd='git diff'
alias gs='git status'
alias ga='git add'
alias gst='git stash'
alias gco='git checkout'
alias gpb='git push -u'

# For finding all my branches that were merged
glist-merged() {
  git for-each-ref --format='%(authorname) %(refname)' --merged | grep 'Gautham Chandra refs/remotes/origin' | awk '{ gsub(/^Gautham Chandra refs\/remotes\/origin\//, ""); print }'
}

# for when I want to checkout a branch that starts with something
gco-grep() {
  git branch | grep "$1" | xargs git checkout
}

# For deleting any local branches that have already been merged on remote
alias gprune-merged='git branch --merged | grep -v -e "master" -e "develop" -e "stage" | xargs -n 1 git branch -d'
