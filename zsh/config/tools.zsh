# Load chruby and enable auto switching when entering a directory containing
# a .ruby-version file.
source '/usr/local/share/chruby/chruby.sh'
source '/usr/local/share/chruby/auto.sh'

save_function()
{
  local ORIG_FUNC="$(declare -f $1)"
  local NEWNAME_FUNC="$2${ORIG_FUNC#$1}"
  eval "$NEWNAME_FUNC"
}
save_function chruby orig_chruby
chruby() {
  orig_chruby $*
  PATH=./bin:$PATH
}

chruby ruby

# Don't create bytecode files:
export PYTHONDONTWRITEBYTECODE=1
# Don't hijack my prompt, please!
export VIRTUAL_ENV_DISABLE_PROMPT=1
# Load pyenv and enable auto switching:
export PYENV_ROOT=/usr/local/var/pyenv
if which pyenv > /dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Link homebrew cask apps in /Applications.
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export MATLABPATH=$HOME/.matlab

# Java:
if which drip > /dev/null 2>&1; then
  export DRIP_SHUTDOWN=30
  export JAVACMD=$(which drip)
fi
