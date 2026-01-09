## grep and alternatives
#

## ripgrep
#
# See: https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md
# See: https://github.com/BurntSushi/ripgrep/blob/master/FAQ.md
#
if [ -f "/usr/bin/rg" ]; then
    alias gr='rg --hidden --line-number --no-heading --follow'
fi
