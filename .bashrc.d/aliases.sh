
## Set custom aliases

# ls
alias la='ls -A'
alias lla='ls -lA'

# exa
if [ -f "/usr/bin/exa" ]; then
    alias exa='exa --group --group-directories-first'
    # alias exa='exa --group --git --group-directories-first'
    alias ls='exa'
    # exa by default don't show '.' and '..', use -aa to show them
    alias la='exa -a'
    alias lla='exa -la'
    # tree view
    alias lt='exa -l --tree'
    alias lta='exa -la --tree'
fi

# size formatting
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# force man pages in en_US instead of whatever is set as LC_MESSAGES
alias man="man -Len_US"

# vim
# vimx is compiled with clipboard support
if [ -f "/usr/bin/vimx" ]; then
    alias vim='vimx'
fi

