## less

## Setup
# 
# See: man less
#
# -R or --RAW-CONTROL-CHARS 
#       support for ANSI escape characters
# --mouse
#       enable mouse support
# --use-color
# -DP+Ybd
#       prompt - light Yellow on blue; bold
# -DN+y
#       line numbers (when using -N) - yellow
# -DE+Wrb
#       errors - light White on red; bold
# -DH+bd
#       headers (--header 1) - blue; bold
# -DS-s
#       search - invert colors
# -DR+gd
#       rscroll - green; bold
#
alias less="less -R --mouse --use-color -DP+bYsd -DN+y -DE+Wrb -DH+bd -DS-s -DR+g"


## NerdFonts support
#
# Properly display wide Unicode characters
#
# export LESSUTFCHARDEF=e000-f8ff:p,f0001-fffff:p
export LESSUTFCHARDEF=e000-e09f:w,e0a0-e0bf:p,e0c0-f8ff:w,f0001-fffff:w

