
## History
# Don't put duplicate lines or lines starting with space in the history.
# Remove previous duplicates
export HISTCONTROL=ignorespace:ignoredups:erasedups
export HISTSIZE=10000


if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

