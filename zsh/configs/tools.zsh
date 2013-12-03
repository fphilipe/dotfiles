# Load chruby and enable auto switching when entering a directory containing
# a .ruby-version file.
source '/usr/local/share/chruby/chruby.sh'
source '/usr/local/share/chruby/auto.sh'
chruby ruby

# Link homebrew cask apps in /Applications.
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
