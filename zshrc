fpath=($HOME/.zsh/func $fpath)
typeset -U fpath

for file ($HOME/.zsh/config/*.zsh); do
  source $file
done

private_path="$HOME/.zshrc-private"
[ -f "$private_path" ] && source $private_path
