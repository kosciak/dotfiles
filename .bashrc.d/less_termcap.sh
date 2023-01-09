
## Colors for less

## termcap terminfo
# ks      smkx      make the keypad send commands
# ke      rmkx      make the keypad send digits
# vb      flash     emit visual bell
# mb      blink     start blink
# md      bold      start bold
# me      sgr0      turn off bold, blink and underline
# so      smso      start standout (reverse video)
# se      rmso      stop standout
# us      smul      start underline
# ue      rmul      stop underline

export LESS_TERMCAP_mb=$BOLD$FG_GREEN
export LESS_TERMCAP_md=$BOLD$FG_BLUE
#export LESS_TERMCAP_md=$BOLD$DIM$FG_BLUE # bold, blue, dimmed (when bold is displayed as bright)
export LESS_TERMCAP_me=$RESET
export LESS_TERMCAP_so=$BOLD$FG_LIGHT_YELLOW$BG_BLUE
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
#export LESS_TERMCAP_us=$UNDERLINE$FG_RED
export LESS_TERMCAP_us=$BOLD$FG_RED
export LESS_TERMCAP_ue=$RESET_UNDERLINE$RESET
export LESS_TERMCAP_mr=$INVERT
export LESS_TERMCAP_mh=$DIM
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

# For Konsole and Gnome-terminal to work (not sure if it breaks something in other terminals)
export GROFF_NO_SGR=1

