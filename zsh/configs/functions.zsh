# Delete local branches that were already merged.
function git_prune_local_branches() {
  branches=$(git branch --merged master | sed '/*/d' | sed '/master/d')
  if [[ $1 = "-f" ]]; then
    echo $branches | xargs git branch -d
  else
    echo 'Would delete (call with -f to delete):'
    echo $branches
  fi
}

# Delete remote merged branches that were already merged.
function git_prune_remote_branches() {
  flag=$1
  branches=`git branch -r --merged origin/master | grep 'origin/' | sed '/master/d'`
  if [[ $flag = "-f" ]]
  then
    branches=`echo $branches | sed "s/origin\//:/g"`
    git push origin $branches
    git remote prune origin
  else
    for branch in `echo $branches`
    do
      echo "Would delete $branch"
    done
  fi
}
