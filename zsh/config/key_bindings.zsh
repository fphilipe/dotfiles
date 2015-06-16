# To find out what the escaped key combination is, open a shell and press ^V
# followed by the combination.

# zsh detects EDITOR=vim and switches to vi key bingings. Use emacs bindings
# instead.
bindkey -e

bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# Make space automatically expand stuff such as "sudo !!".
bindkey ' ' magic-space

# Make shift-tab select the previous item in the completion menu.
bindkey '^[[Z' reverse-menu-complete

# Make the delete key work instead of outputting a ~.
bindkey "^[[3~" delete-char
