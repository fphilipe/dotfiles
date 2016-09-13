# Enable colors in zsh.
autoload colors && colors

# Enable colors in ls.
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Base16 Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
