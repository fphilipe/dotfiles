# This file needs to be sourced first, that's why its name has a leading
# underscore.

# cd into dir without cd.
setopt auto_cd
# cd into variables without cd or ~.
setopt cdable_vars
# Ignore commands starting with a space. Useful when running commands containing
# sensible information.
setopt histignorespace

# Don't use auto correction.
setopt no_correct_all

# Enable tab completion for binaries such as git.
autoload compinit && compinit

# Disable reflow so that ^Q works in vim.
stty -ixon

# Quote pasted URLs.
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
