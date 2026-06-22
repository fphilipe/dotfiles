eval "$(/opt/homebrew/bin/brew shellenv)"

paths=(
  # Node Packace Manager
  '/usr/local/share/npm/bin'
  './node_modules/.bin'
  "$HOME/.yarn/bin"
  "$HOME/.config/yarn/global/node_modules/.bin"
  # Haskell
  "$HOME/.cabal/bin"
  # Rust
  "$HOME/.cargo/bin"
  # .NET
  "$HOME/.dotnet/tools"
  # Mint
  "$HOME/.mint/bin"
  # Heroku toolbelt
  '/usr/local/heroku/bin'
  # PNPM
  "$PNPM_HOME"
  # Python via Homebrew
  "$(brew --prefix python)/libexec/bin"
  # Git contrib (diff-highlight)
  "$(brew --prefix git)/share/git-core/contrib/diff-highlight"
  # Android
  "$ANDROID_HOME/platform-tools"
  "$HOME/.local/bin:$PATH"
  # personal scripts
  "$HOME/.bin"
  # project scripts
  './bin'
)

for i in $paths; do
  export PATH="$i:$PATH"
done
