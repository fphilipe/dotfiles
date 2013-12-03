# This file needs to be sourced first, that's why its name has a leading
# underscore.

# cd into dir without cd.
setopt auto_cd
# cd into variables without cd or ~.
setopt cdable_vars

# Don't use auto correction.
setopt no_correct_all

# Enable tab completion for binaries such as git.
autoload compinit && compinit

# Disable reflow so that ^Q works in vim.
stty -ixon
