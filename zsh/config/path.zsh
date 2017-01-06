paths=(
  # Homebrew
  '/usr/local/bin'
  '/usr/local/sbin'
  # personal scripts
  "$HOME/.bin"
  # Node Packace Manager
  '/usr/local/share/npm/bin'
  './node_modules/.bin'
  # Haskell
  "$HOME/.cabal/bin"
  # Heroku toolbelt
  '/usr/local/heroku/bin'
  # Bundler binstubs
  './bin'
)

for i in $paths; do
  export PATH="$i:$PATH"
done
