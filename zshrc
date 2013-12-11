for file ($HOME/.zsh/*.zsh); do
  source $file
done

private_path="$HOME/.zshrc-private"
[ -f "$private_path" ] && source $private_path
