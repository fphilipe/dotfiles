# To find out what the escaped key combination is, open a shell and press ^V
# followed by the combination.

# Use vim key bindings. When pressing escape, we get into normal mode and can
# use vim motions to get around quickly.
bindkey -v

# Enable reverse and forward history search.
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# Make space automatically expand stuff such as "sudo !!".
bindkey ' ' magic-space

# Make shift-tab select the previous item in the completion menu.
bindkey '^[[Z' reverse-menu-complete

# Make the delete key work instead of outputting a ~.
bindkey "^[[3~" delete-char

# Make common keys work also in vim mode.
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^[b' backward-word
bindkey '^[f' forward-word
