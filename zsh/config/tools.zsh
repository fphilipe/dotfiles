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

if which fnm > /dev/null 2>&1; then
  eval "$(fnm env --shell=zsh)"

  # This code was generated using `fnm env --use-on-cd` and modified not to
  # print anything.
  autoload -U add-zsh-hook
  _fnm_autoload_hook () {
    if [[ -f .node-version && -r .node-version ]]; then
      fnm use > /dev/null
    elif [[ -f .nvmrc && -r .nvmrc ]]; then
      fnm use > /dev/null
    fi
  }
  add-zsh-hook chpwd _fnm_autoload_hook && _fnm_autoload_hook
fi

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
export HOMEBREW_NO_INSTALL_CLEANUP=1

export MATLABPATH=$HOME/.matlab

# Java:
if which drip > /dev/null 2>&1; then
  export DRIP_SHUTDOWN=30
  export JAVACMD=$(which drip)
fi

# Android:
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
