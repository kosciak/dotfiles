## kitty shell integration
#
# See: https://sw.kovidgoyal.net/kitty/shell-integration/#manual-shell-integration
#
# NOTE: Manual integration to work well with direnv initialization
#

if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="no-cursor"
    source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi

