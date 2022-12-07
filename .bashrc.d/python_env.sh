
# Virtualenvwrapper settings and startup
# TODO: Change to WORKON_HOME to ~/.virtualenvs
export WORKON_HOME=$HOME/projekty/.virtualenvs
export PROJECT_HOME=$HOME/projekty

if [ -f ~/.local/bin/virtualenvwrapper.sh ]; then
    source ~/.local/bin/virtualenvwrapper.sh
elif [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
else
    : # virtualenvwrapper.sh not installed
fi

