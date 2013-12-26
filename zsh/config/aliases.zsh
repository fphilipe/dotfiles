# Use list style, list everything, show size with units.
alias ls='ls -lah'
# Always use the same socket.
alias tmux='tmux -S /tmp/tmux'
# Quicklook a file from terminal.
alias ql='qlmanage -p "$@" > /dev/null'
# Use hub as a git wrapper.
alias git=hub
compdef hub=git
# Reload zshrc.
alias reload!='. ~/.zshrc'
