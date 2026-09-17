# Env setup is here, not in `.zshrc`, so GUI apps that spawn a login shell (MacVim) get it.
for file ($HOME/.zsh/profile/*.zsh); do
  source $file
done
