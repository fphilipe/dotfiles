# Substitute color vars in PROMPT var.
setopt prompt_subst

PROMPT='%D{%m/%d %H:%M} %{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}$(hostname -s) %{$fg_bold[green]%}%~%{$reset_color%} ${$(git_prompt_info)%.}❯ '
TMOUT=60
TRAPALRM() {
  zle reset-prompt
}

# Returns the current branch name and its status using colored dots as indicator.
function git_prompt_info() {
  local s="$(git status --short --branch --porcelain 2> /dev/null)"
  [ "$s" = '' ] && echo "\n." && return
  local sha="$(git rev-parse --short HEAD 2> /dev/null)"
  local first_line="$(head -n1 <<< $s)"
  local branch="$(<<< "$first_line" | sed -E 's/^## (.*)(\.\.\..*)?$/\1/')"
  local ahead="$(sed -e '/ahead/!d' -e 's/.*ahead \([0-9]*\).*/+\1/' <<< $first_line)"
  local behind="$(sed -e '/behind/!d' -e 's/.*behind \([0-9]*\).*/-\1/' <<< $first_line)"
  local staged="$(awk '/^[MDA]. / { print "•"; exit }' <<< $s)"
  local modified="$(awk '/^.[MD] / { print "•"; exit }' <<< $s)"
  local untracked="$(awk '/^\?\? / { print "•"; exit }' <<< $s)"
  local conflict="$(awk '/^UU / { print "•"; exit }' <<< $s)"
  echo "%{$fg_bold[blue]%}%{$branch%}%{$reset_color%}@%{$fg[yellow]%}$sha%{$fg[green]%} $ahead%{$fg[red]%}$behind\n%{$fg[green]%}$staged%{$fg[red]%}$modified%{$fg[yellow]%}$untracked%{$fg[blue]%}$conflict%{$reset_color%}";
}
