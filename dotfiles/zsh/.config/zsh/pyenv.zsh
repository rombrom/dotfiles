export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# This is making zsh SSSSSSSSLLLLLLOOOOOOOOWWWWW
# eval "$(pyenv init -)"

# Lazy load pyenv
# Shamelessly borrowed from
# https://github.com/davidparsson/zsh-pyenv-lazy/blob/master/pyenv-lazy.plugin.zsh
if type pyenv > /dev/null; then
    export PATH="${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}"
    function pyenv() {
        unset -f pyenv
        eval "$(command pyenv init -)"
        if [[ -n "${ZSH_PYENV_LAZY_VIRTUALENV}" ]]; then
            eval "$(command pyenv virtualenv-init -)"
        fi
        pyenv $@
    }
fi
