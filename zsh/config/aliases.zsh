# Use list style, list everything, show size with units.
alias ls='ls -lah'
# Always use the same socket.
alias tmux='tmux -S /tmp/tmux'
# Quicklook a file from terminal.
alias ql='qlmanage -p "$@" &> /dev/null'
# Reload zshrc.
alias reload!='. ~/.zshrc'
# Homebrew package which corrects your previous console command.
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
