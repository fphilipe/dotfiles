eval "$(/opt/homebrew/bin/brew shellenv)"

source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"

# Load chruby and enable auto switching when entering a directory containing
# a .ruby-version file.
source "$HOMEBREW_PREFIX/share/chruby/chruby.sh"
source "$HOMEBREW_PREFIX/share/chruby/auto.sh"

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
  # `recursive` lets `fnm use` resolve the version file from parent folders.
  eval "$(fnm env --shell=zsh --version-file-strategy=recursive)"

  # This code was generated using `fnm env --use-on-cd` and modified not to
  # print anything and to look for a version file in parent folders, stopping
  # at the git repo root so we don't pick up an unrelated version file above it.
  autoload -U add-zsh-hook
  _fnm_autoload_hook () {
    local dir=$PWD
    # The repo root bounds the upward search; fall back to $PWD outside a repo.
    local root=${$(git rev-parse --show-toplevel 2>/dev/null):-$PWD}
    while true; do
      if [[ -r $dir/.node-version || -r $dir/.nvmrc ]]; then
        fnm use > /dev/null
        return
      fi
      [[ $dir == "$root" ]] && return
      dir=${dir%/*}
    done
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
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export ANDROID_HOME="$HOME/Library/Android/sdk"

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# .NET:
export DOTNET_ROOT="/usr/local/opt/dotnet/libexec"
export PLAYWRIGHT_NODEJS_PATH=$(which node)

# 1Password biometric unlock:
export OP_BIOMETRIC_UNLOCK_ENABLED=true

# GPG signing:
export GPG_TTY=$(tty)

# pnpm:
export PNPM_HOME="$HOME/Library/pnpm"

# Disable Husky (https://github.com/typicode/husky) globally (I have my own Git hooks):
export HUSKY=0
