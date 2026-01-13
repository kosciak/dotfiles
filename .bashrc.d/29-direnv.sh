## direnv
#
# Automatically load and unload enviromental variables
#
# See: https://github.com/direnv/direnv
#
# NOTE: direnv must come AFTER everything that changes PROMPT_COMMAND
#

if [ -f "/usr/bin/direnv" ]; then
    eval "$(direnv hook bash)"
fi

