
## Set custom aliases

# ls
alias la='ls -A'
alias lla='ls -lA'

# size formatting
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# force man pages in en_US instead of whatever is set as LC_MESSAGES
alias man="man -Len_US"

