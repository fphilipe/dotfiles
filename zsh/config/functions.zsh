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

  [[ -z "$prompt" && ! -t 0 ]] && prompt="$(cat)"

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

  local current_session="$(tmux display-message -p '#S')"
  local session_name="${current_session%%/*}/${branch//\//-}"
  tmux new-session -d -s "$session_name" -c "$working_dir" -n vim
  tmux new-window -t "$session_name" -c "$working_dir" -n sh
  tmux new-window -t "$session_name" -c "$working_dir" -n claude
  local claude_cmd="claude --name ${(qq)branch}"
  if [[ -n "$prompt" ]]; then
    # `send-keys` types newlines as Enter, so encode them as `$'\n'`.
    claude_cmd+=" ${(q+)prompt}"
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

  trash "$worktree" || return 1
  git -C "$main_repo_dir" worktree prune

  local last_session
  last_session="$(tmux display-message -p '#{client_last_session}')"
  if [[ -n "$last_session" && "$last_session" != "$session" ]]; then
    tmux switch-client -l
  fi
  tmux kill-session -t "$session"
}

function tidy-workspaces() {
  local -a run
  local OPTIND opt
  while getopts "n" opt; do
    case "$opt" in
      n) run=(echo "Would run:") ;;
      *) echo "usage: tidy-workspaces [-n]" >&2; return 1 ;;
    esac
  done

  local common_dir main_repo_dir
  common_dir="$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)" || {
    echo "tidy-workspaces: not in a git repo" >&2
    return 1
  }
  main_repo_dir="${common_dir:h}"

  # Upstream shows as `[gone]` only after stale remote-tracking refs are pruned.
  git -C "$main_repo_dir" fetch --prune --quiet

  local line session session_path worktree branch current_session kill_current
  [[ -n "$TMUX" ]] && current_session="$(tmux display-message -p '#S')"

  for line in ${(f)"$(tmux list-sessions -F "#{session_name}"$'\t'"#{session_path}" 2>/dev/null)"}; do
    session="${line%%$'\t'*}"
    session_path="${line#*$'\t'}"
    [[ -d "$session_path" ]] || continue
    [[ "$(git -C "$session_path" rev-parse --path-format=absolute --git-common-dir 2>/dev/null)" == "$common_dir" ]] || continue
    worktree="$(git -C "$session_path" rev-parse --show-toplevel)"
    [[ "$worktree" == "$main_repo_dir" ]] && continue

    branch="$(git -C "$worktree" rev-parse --abbrev-ref HEAD)"
    [[ "$(git -C "$worktree" for-each-ref --format='%(upstream:track)' "refs/heads/$branch")" == "[gone]" ]] || continue

    if [[ -n "$(git -C "$worktree" status --porcelain)" ]]; then
      echo "Skipped $session: $worktree is dirty"
      continue
    fi

    echo "Trash workspace $session: $worktree"
    $run trash "$worktree" || continue
    if [[ "$session" == "$current_session" ]]; then
      kill_current=1
    else
      $run tmux kill-session -t "$session"
    fi
  done

  $run git -C "$main_repo_dir" worktree prune

  local dir
  local -a worktrees
  worktrees=(${(f)"$(git -C "$main_repo_dir" worktree list --porcelain | sed -n 's/^worktree //p')"})
  for dir in "$main_repo_dir"@*(N/); do
    (( ${worktrees[(Ie)$dir]} )) && continue
    echo "Trash leftover: $dir"
    $run trash "$dir"
  done

  $run git -C "$main_repo_dir" tidy

  # Killing the current session also kills this shell, so do it last.
  if [[ -n "$kill_current" ]]; then
    $run tmux switch-client -l
    $run tmux kill-session -t "$current_session"
  fi
}
