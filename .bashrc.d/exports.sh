
## Locale
# Force english
# export LC_ALL=C


## History
# Don't put duplicate lines or lines starting with space in the history.
# Remove previous duplicates
export HISTCONTROL=ignorespace:ignoredups:erasedups
export HISTSIZE=10000


## NerdFonts support in less
# export LESSUTFCHARDEF=e000-f8ff:p,f0001-fffff:p
export LESSUTFCHARDEF=e000-e09f:w,e0a0-e0bf:p,e0c0-f8ff:w,f0001-fffff:w


## Setup XDG_* directories
#  See: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi

if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi

if [ -z "$XDG_STATE_HOME" ] ; then
    export XDG_STATE_HOME="$HOME/.local/state"
fi

