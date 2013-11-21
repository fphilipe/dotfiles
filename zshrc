export LANG="en_US.UTF-8"
export EDITOR=vim

# Enable vi mode
bindkey -v

# Aliases
alias ls="ls -l"
alias -s md="open -a Marked"
# QuickLook
alias ql='qlmanage -p "$@" > /dev/null'
function git(){hub "$@"}

# Fetch all remotes
function git_fetch_remotes() {
  for remote in `git remote`
  do
    git fetch $remote
  done
}

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

for config_file ($HOME/.zsh/lib/*.zsh); do
  source $config_file
done

# Enable tab completion for binaries such as git:
autoload -U compinit
compinit

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}$(hostname -s)%{$reset_color%} %{$fg_bold[green]%}%~%{$reset_color%} $(git_prompt_info)$ '

# Returns the current branch name and its status using colored dots as indicator.
function git_prompt_info() {
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
   git_status=$(git status -sb)
       branch=$(echo "$git_status" | sed -e '/^## /!d' -e 's/## //' -e 's/\.\.\..*//')
        ahead=$(echo "$git_status" | sed -e '/^## .*\[ahead/!d' -e 's/.*ahead \([0-9]*\).*/+\1/')
       behind=$(echo "$git_status" | sed -e '/^## .*[, \[]behind/!d' -e 's/.*behind \([0-9]*\).*/-\1/')
       staged=$(echo "$git_status" | sed -e '/^[MDA]. /!d' | tail -1 | sed -e 's/.*/•/')
     modified=$(echo "$git_status" | sed -e '/^.[MD] /!d' | tail -1 | sed -e 's/.*/•/')
    untracked=$(echo "$git_status" | sed -e '/^?? /!d' | tail -1 | sed -e 's/.*/•/')
     conflict=$(echo "$git_status" | sed -e '/^UU /!d' | tail -1 | sed -e 's/.*/•/')
    echo "| $branch ($(git_prompt_short_sha)) %{$fg[green]%}$ahead%{$fg[red]%}$behind\n%{$fg[green]%}$staged%{$fg[red]%}$modified%{$fg[yellow]%}$untracked%{$fg[blue]%}$conflict%{$reset_color%}";
  fi
}

# Disable reflow so that CTRL-Q works in vim.
stty -ixon

# Link homebrew cask apps in /Applications.
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Prevent setting paths multiple times:
# homebrew
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
# personal scripts
export PATH="$HOME/.scripts:$PATH"
# Node Packace Manager
export PATH="/usr/local/share/npm/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"
# Python virtualenv
export PATH="$HOME/.virtualenv/default_env/bin:$PATH"
# Load rbenv
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# bundler binstubs
export PATH="./bin:$PATH"
