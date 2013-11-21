# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Disable this oh-my-zsh feature since it messes with tmux window names.
DISABLE_AUTO_TITLE=true

export LANG="en_US.UTF-8"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="philipe"

export EDITOR=vim

# Link homebrew cask apps in /Applications.
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Enable vi mode
bindkey -v

# Aliases
alias ls="ls -l"
alias -s md="open -a Marked"
# QuickLook
alias ql='qlmanage -p "$@" > /dev/null'
function git(){hub "$@"}

# Returns the current branch name and its status using colored dots as indicator.
function git_prompt_info() {
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
   git_status=$(/usr/local/bin/git status -sb)
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

# Functions
function h-pro() {
  heroku $@ --app lu-production
}

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

# Markdown and open in browser
function markdown() {
  kramdown "$1" | bcat;
}

function bump_version() {
  echo $1 > VERSION && git commit -m "Bump version to $1" -- VERSION && git tag "v$1"
}

function build_gem() {
  gem build *.gemspec
}

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  brew
  gem
  git
  heroku
  osx
  powder
  rails
  ruby
  ssh-agent
  tmux
  tmuxinator
  zeus
)

source $ZSH/oh-my-zsh.sh

# Disable reflow so that CTRL-Q works in vim.
stty -ixon

# Don't use autocorrection.
unsetopt correct_all
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
