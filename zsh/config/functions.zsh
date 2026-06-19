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

function mkcd() {
  mkdir -p "$@" && cd "$_";
}

function new_workspace() {
  local branch="$1"
  local base="$2"
  [[ -z "$branch" ]] && { echo "usage: new_workspace <branch> [base]" >&2; return 1; }
  [[ -z "$TMUX" ]] && { echo "new_workspace: must be run inside tmux" >&2; return 1; }

  local common_dir
  common_dir="$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)" || {
    echo "new_workspace: not in a git repo" >&2
    return 1
  }

  local main_repo_dir="$(dirname "$common_dir")"
  local prefix="$(git rev-parse --show-prefix)"
  local worktree_dir="$main_repo_dir@${branch//\//-}"
  local working_dir="$worktree_dir/$prefix"
  local current_branch="$(git rev-parse --abbrev-ref HEAD)"

  if git show-ref --verify --quiet "refs/heads/$branch"; then
    git worktree add "$worktree_dir" "$branch" || return
  else
    git worktree add -b "$branch" "$worktree_dir" "${base:-$current_branch}" || return
  fi

  if [[ -f "$main_repo_dir/.claude/settings.local.json" ]]; then
    mkdir -p "$working_dir/.claude"
    ln -s "$main_repo_dir/.claude/settings.local.json" "$working_dir/.claude/settings.local.json"
  fi

  local window_id
  window_id="$(tmux new-window -P -F '#{window_id}' -c "$working_dir" -n "$branch")"
  tmux split-pane -t "$window_id" -h -c "$working_dir"
  tmux split-pane -t "$window_id" -v -c "$working_dir"
  tmux send-keys -t "$window_id.1" vim Enter
  tmux send-keys -t "$window_id.2" "claude --name '$branch'" Enter
  tmux select-pane -t "$window_id.2"
}

function kill_workspace() {
  [[ -z "$TMUX" ]] && { echo "kill_workspace: must be run inside tmux" >&2; return 1; }

  local worktree branch common_dir main_repo_dir
  worktree="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    echo "kill_workspace: not in a git repo" >&2
    return 1
  }
  branch="$(tmux display-message -p '#W')"
  common_dir="$(git rev-parse --path-format=absolute --git-common-dir)"
  main_repo_dir="$(dirname "$common_dir")"

  if [[ "$main_repo_dir" == "$worktree" ]]; then
    echo "kill_workspace: refusing to remove main worktree" >&2
    return 1
  fi

  if [[ -n "$(git -C "$worktree" status --porcelain)" ]]; then
    echo "kill_workspace: working directory is dirty, refusing to proceed" >&2
    return 1
  fi

  if [[ -n "$branch" ]]; then
    local default_branch="$(git config init.defaultBranch)"

    git -C "$worktree" switch --detach "$default_branch" || {
      echo "kill_workspace: failed to detach to '$default_branch'" >&2
      return 1
    }
  fi

  git -C "$main_repo_dir" worktree remove "$worktree" || return 1
  tmux kill-window
}
