eval "$(/opt/homebrew/bin/brew shellenv)"

paths=(
  # personal scripts
  "$HOME/.bin"
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
  # Heroku toolbelt
  '/usr/local/heroku/bin'
  # Bundler binstubs
  './bin'
  # PNPM
  "$HOME/Library/pnpm"
)

for i in $paths; do
  export PATH="$i:$PATH"
done
