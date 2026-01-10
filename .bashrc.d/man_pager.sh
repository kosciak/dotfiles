## man

## Language
#
# force man pages in en_US instead of whatever is set as LC_MESSAGES
#
alias man="man -Len_US"


## Show colors
# 
export GROFF_NO_SGR=1
# NOTE: setting MANROFFOPT instead might also work?
# export MANROFFOPT="-c"


## Set pager for man
#
# Use: less
#
# Show more verbose status line
# See: https://stackoverflow.com/questions/1049350/how-to-make-less-indicate-location-in-percentage/19871578#19871578
# see: https://felipec.wordpress.com/2021/06/05/adventures-with-man-color/
#
# -s or --squeeze-blank-lines
#       Causes consecutive blank lines to be squeezed into a single blank line
# -M or --LONG-PROMPT
#       verbose prompt
# -Dd+b
#       bold - blue
# -Du+r
#       underline - red
# +Gg
#       This has something to do with properly/faster(?) calculating position % in prompt
#
# export MANPAGER='less --mouse -s -M +Gg'
export MANPAGER='less --mouse -R -i -s -M -Dd+b -Du+r +Gg'


# Use: vim
# NOTE: ftplugin/man.vim must be enabled
# export MANPAGER="vim +MANPAGER --not-a-term -"

