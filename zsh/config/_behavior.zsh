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

# Disable "delayed suspension" in order for C-y to work correctly in GHCi.
# See https://stackoverflow.com/questions/46290504/haskell-ghci-treats-ctrl-y-like-ctrl-z
stty dsusp undef

# Quote pasted URLs.
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Edit the command line with $EDITOR.
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
