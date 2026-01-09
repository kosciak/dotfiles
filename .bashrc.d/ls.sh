## ls and alternatives
#

alias la='ls -A'
alias lla='ls -lA'
alias ll.='ll -d .*'


## eza
#
# Replacement for ls
#
# NOTE: It is NOT an drop-in replacement as -t option is not supported!
# 
# See: https://eza.rocks/
#

if [ -f "/usr/bin/eza" ]; then
    # NOTE: eza is a fork of exa that is still maintained
    alias eza='eza --group --icons --classify'

    # Consider: https://github.com/eza-community/eza/issues/980#issuecomment-2499761779

    # NOTE: Keep original ls intact for backward compatibility
    # alias ls='eza'
    alias ll='eza -l --group-directories-first'
    alias l.='eza -d --group-directories-first .*'
    alias ll.='eza -ld --group-directories-first .*'

    # NOTE: exa/eza by default don't support -A and don't show '.' and '..' dirs
    #       Use -aa to show them
    alias la='eza -a'
    alias lla='eza -la --group-directories-first'

    # shorthand for: ls -lt
    alias lt='eza --sort new --reverse'
    alias llt='eza -l --group-directories-first --sort new --reverse'
    alias lta='eza -la --group-directories-first --sort new --reverse'
fi


## exa
#
# NOTE: Unmaintaned!
if [ -f "/usr/bin/exa" ]; then
    # alias exa='exa --group --git --icons --classify'
    alias exa='exa --group --icons --classify'

    # NOTE: Keep original ls intact for backward compatibility
    # alias ls='exa'
    alias ll='exa -l --group-directories-first'
    alias l.='exa -d --group-directories-first .*'

    # NOTE: exa/eza by default don't support -A and don't show '.' and '..' dirs
    #       Use -aa to show them
    alias la='exa -a'
    alias lla='exa -la --group-directories-first'

    # shorthand for: ls -lt
    alias lt='exa --sort new --reverse'
    alias llt='exa -l --group-directories-first --sort new --reverse'
    alias lta='exa -la --group-directories-first --sort new --reverse'
fi

