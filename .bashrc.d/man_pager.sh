
## Set pager for man

# Use: less
# Show more verbose status line
# See: https://stackoverflow.com/questions/1049350/how-to-make-less-indicate-location-in-percentage/19871578#19871578
export MANPAGER='less -s -M +Gg'

# Use: vim
# NOTE: ftplugin/man.vim must be enabled
# export MANPAGER="vim +MANPAGER --not-a-term -"

