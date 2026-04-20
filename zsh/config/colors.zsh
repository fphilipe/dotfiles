# Enable colors in zsh.
autoload colors && colors

# Enable colors in ls.
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Base16 Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && source "$BASE16_SHELL/profile_helper.sh"

base16_random() {
  local scripts=($BASE16_SHELL/scripts/base16-*.sh)
  local script=$scripts[RANDOM%${#scripts[@]}+1]
  eval "${${script:t:r}/base16-/base16_}"
  echo "$BASE16_THEME"
}
