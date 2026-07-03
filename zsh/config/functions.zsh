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

function new-workspace() {
  local branch="$1"
  [[ -z "$branch" ]] && { echo "usage: new-workspace <branch> [-b base] [-p prompt]" >&2; return 1; }
  shift

  local base prompt OPTIND OPTARG opt
  while getopts "b:p:" opt; do
    case "$opt" in
      b) base="$OPTARG" ;;
      p) prompt="$OPTARG" ;;
      *) echo "usage: new-workspace <branch> [-b base] [-p prompt]" >&2; return 1 ;;
    esac
  done

  [[ -z "$TMUX" ]] && { echo "new-workspace: must be run inside tmux" >&2; return 1; }

  local common_dir
  common_dir="$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)" || {
    echo "new-workspace: not in a git repo" >&2
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

  local current_session="$(tmux display-message -p '#S')"
  local session_name="${current_session%%/*}/${branch//\//-}"
  tmux new-session -d -s "$session_name" -c "$working_dir" -n vim
  tmux new-window -t "$session_name" -c "$working_dir" -n sh
  tmux new-window -t "$session_name" -c "$working_dir" -n claude
  local claude_cmd="claude --name '$branch'"
  if [[ -n "$prompt" ]]; then
    claude_cmd+=" '${prompt//\'/\'\\\'\'}'"
  fi

  tmux send-keys -t "${session_name}:vim" vim Enter
  tmux send-keys -t "${session_name}:claude" "$claude_cmd" Enter
  tmux switch-client -t "$session_name"
}

function kill-workspace() {
  [[ -z "$TMUX" ]] && { echo "kill-workspace: must be run inside tmux" >&2; return 1; }

  local session common_dir main_repo_dir worktree branch
  session="$(tmux display-message -p '#S')"

  common_dir="$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)" || {
    echo "kill-workspace: not in a git repo" >&2
    return 1
  }
  main_repo_dir="$(dirname "$common_dir")"
  worktree="$main_repo_dir@${session#*/}"

  if [[ "$main_repo_dir" == "$worktree" ]]; then
    echo "kill-workspace: refusing to remove main worktree" >&2
    return 1
  fi

  if ! git -C "$worktree" rev-parse --git-dir &>/dev/null; then
    echo "kill-workspace: no worktree found for session '$session'" >&2
    return 1
  fi

  if [[ -n "$(git -C "$worktree" status --porcelain)" ]]; then
    echo "kill-workspace: working directory is dirty, refusing to proceed" >&2
    return 1
  fi

  branch="$(git -C "$worktree" rev-parse --abbrev-ref HEAD)"
  if [[ -n "$branch" && "$branch" != "HEAD" ]]; then
    local default_branch="$(git config init.defaultBranch)"

    git -C "$worktree" switch --detach "$default_branch" || {
      echo "kill-workspace: failed to detach to '$default_branch'" >&2
      return 1
    }
  fi

  git -C "$main_repo_dir" worktree remove "$worktree" || return 1

  local last_session
  last_session="$(tmux display-message -p '#{client_last_session}')"
  if [[ -n "$last_session" && "$last_session" != "$session" ]]; then
    tmux switch-client -l
  fi
  tmux kill-session -t "$session"
}
