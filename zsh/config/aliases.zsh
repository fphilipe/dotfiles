# Use list style, list everything, show size with units.
alias ls='ls -lahp'
# Always use the same socket.
alias tmux='tmux -S /tmp/tmux'
# Quicklook a file from terminal.
alias ql='qlmanage -p "$@" &> /dev/null'
alias g="git"
alias gn="git --no-pager"
# ripgrep with just the matches.
alias rgm='rg --only-matching --no-filename --no-line-number --no-heading'
alias rgf='rg --files-with-matches'
# cd to repo root dir.
alias cdr='cd "$(git rev-parse --show-cdup)"'
# Use Android Studio's keytool instead of global keytool that would require
# installing a Java runtime.
alias keytool="/Applications/Android\ Studio.app/Contents/jbr/Contents/Home/bin/keytool"
