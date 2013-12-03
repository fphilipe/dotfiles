# Substitute color vars in PROMPT var.
setopt prompt_subst

PROMPT='$fg[magenta]%n$reset_color@$fg[yellow]$(hostname -s)$reset_color $fg_bold[green]%~$reset_color $(git_prompt_info)❯ '

# Returns the current branch name and its status using colored dots as indicator.
function git_prompt_info() {
  local s="$(git status --short --branch --porcelain 2> /dev/null)"
  [ "$s" = '' ] && return
  local sha="$(git rev-parse --short HEAD)"
  local first_line="$(head -n1 <<< $s)"
  local branch="$(awk -F'\\s+|\\.+' '{ print $2 }' <<< "$first_line")"
  local ahead="$(sed -e '/ahead/!d' -e 's/.*ahead \([0-9]*\).*/+\1/' <<< $first_line)"
  local behind="$(sed -e '/behind/!d' -e 's/.*behind \([0-9]*\).*/-\1/' <<< $first_line)"
  local staged="$(awk '/^[MDA]. / { print "•" }' <<< $s)"
  local modified="$(awk '/^.[MD] / { print "•" }' <<< $s)"
  local untracked="$(awk '/^?? / { print "•" }' <<< $s)"
  local conflict="$(awk '/^UU / { print "•" }' <<< $s)"
  echo "$fg_bold[blue]$branch$reset_color@$fg[yellow]$sha$fg[green] $ahead$fg[red]$behind\n$fg[green]$staged$fg[red]$modified$fg[yellow]$untracked$fg[blue]$conflict$reset_color";
}
