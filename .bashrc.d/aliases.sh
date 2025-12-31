
## Set custom aliases

# ls
alias la='ls -A'
alias lla='ls -lA'
alias ll.='ll -d .*'


# exa
if [ -f "/usr/bin/exa" ]; then
    # alias exa='exa --group --git --icons --classify'
    alias exa='exa --group --icons --classify'
fi
if [ -f "/usr/bin/eza" ]; then
    # NOTE: eza is a fork of exa that is still maintained
    alias eza='eza --group --icons --classify'

    # Consider: https://github.com/eza-community/eza/issues/980#issuecomment-2499761779

    # NOTE: Keep original ls intact for backward compatibility
    # alias ls='eza'
    alias ll='eza -l --group-directories-first'
    alias l.='eza -d --group-directories-first .*'

    # NOTE: exa/eza by default don't support -A and don't show '.' and '..' dirs
    #       Use -aa to show them
    alias la='eza -a'
    alias lla='eza -la --group-directories-first'

    # shorthand for: ls -lt
    alias lt='eza -l --group-directories-first --sort new --reverse'
    alias lta='eza -la --group-directories-first --sort new --reverse'
fi


# ripgrep
if [ -f "/usr/bin/rg" ]; then
    alias gr='rg --hidden --line-number --no-heading --follow'
fi


# size formatting
alias df='df -h'        # human-readable sizes
alias free='free -m'    # show sizes in MB


# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'


# less - enable mouse scrolling
alias less="less --mouse"

# force man pages in en_US instead of whatever is set as LC_MESSAGES
alias man="man -Len_US"


# vim
if [ -f "/usr/bin/vimx" ]; then
    # NOTE: vimx is compiled with clipboard support
    alias vim='vimx'
fi

