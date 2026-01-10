## Python virtual environments
#

## Virtualenvwrapper settings and startup
#
# See: https://virtualenvwrapper.readthedocs.io/en/stable/
#

export WORKON_HOME=$HOME/.cache/venvs
export PROJECT_HOME=$HOME/projekty

# Don't add ENV name to PS1 as it will be overwritten by __git_ps1 anyway
export VIRTUAL_ENV_DISABLE_PROMPT=1
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1


# Do NOT source virtualenvwrapper.sh when already in ENV
if [[ -z "$VIRTUAL_ENV" ]]; then
    if [ -f ~/.local/bin/virtualenvwrapper.sh ]; then
        source ~/.local/bin/virtualenvwrapper.sh
    elif [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
        source /usr/local/bin/virtualenvwrapper.sh
    else
        : # virtualenvwrapper.sh not installed
    fi
fi

