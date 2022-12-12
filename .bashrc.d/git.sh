## Setup git-prompt

# Source if present
if ! type __git_ps1 &> /dev/null && [ -e /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
fi

# Set options
if type __git_ps1 &> /dev/null; then
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=''
    export GIT_PS1_COMPRESSSPARSESTATE=1
    export GIT_PS1_SHOWUPSTREAM="auto"

    # export GIT_PS1_STATESEPARATOR=':'
    export GIT_PS1_STATESEPARATOR=''

    export GIT_PS1_DESCRIBE_STYLE='describe'

    export GIT_PS1_SHOWCOLORHINTS=1

    export GIT_PS1_HIDE_IF_PWD_IGNORED=1
fi
