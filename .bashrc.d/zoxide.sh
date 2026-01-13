## zoxide
#
# Smart cd command to jump into most used directiories
#
# See: https://github.com/ajeetdsouza/zoxide
#

if [ -f "/usr/bin/zoxide" ]; then
    eval "$(zoxide init --cmd j bash)"
fi

