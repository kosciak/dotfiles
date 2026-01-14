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

# on .envrc load and unload print in DIM color
# See: https://esham.io/2023/10/direnv
export DIRENV_LOG_FORMAT=$'\033[2mdirenv: %s\033[0m'

