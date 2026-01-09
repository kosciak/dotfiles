## Bash options and settings

## History
#
# Don't put duplicate lines or lines starting with space in the history.
# Remove previous duplicates
export HISTCONTROL=ignorespace:ignoredups:erasedups
export HISTSIZE=10000

## Options
#
# shopt - list all
#
shopt -s cdspell    # autocorrects cd misspellings
#shopt -s direxpand  # 
#shopt -s dirspell   # autocorrects dir names on tab completion

