
# NOTE: Using colors and attributes defined in /etc/profile.d/attrs_colors.sh

# Mark colors as non printable characters, otherwise wrong length of prompt would be calculated
color() {
	echo "\[$1\]";
}


## Set PS* prompts
if [[ ! -z $BASH ]]; then
	PS1="[\u@\h \w] \$"

    if [[ $EUID -eq 0 ]]; then
		# Logged as root
		PS1_PRE="$(color $RESET)"
		PS1_PRE+="$(color $FG_YELLOW)[$(color $RESET)"
		PS1_PRE+="$(color $FG_RED)\u$(color $RESET)"
		PS1_PRE+="@"
		PS1_PRE+="$(color $FG_RED)\h$(color $RESET)"
		PS1_PRE+=" "
		PS1_PRE+="$(color $FG_YELLOW)\w$(color $RESET)"
		PS1_PRE+="$(color $RESET)"

		PS1_POST="$(color $RESET)"
		PS1_POST+="$(color $FG_YELLOW)]$(color $RESET)"
		PS1_POST+=" \$ "
		PS1_POST+="$(color $RESET)"
    else
		# Normal user
		PS1_PRE="$(color $RESET)"
		PS1_PRE+="$(color $FG_CYAN)[$(color $RESET)"
		PS1_PRE+="$(color $FG_BLUE)\u$(color $RESET)"
		PS1_PRE+="@"
		PS1_PRE+="$(color $FG_BLUE)\h$(color $RESET)"
		PS1_PRE+=" "
		PS1_PRE+="$(color $FG_GREEN)\w$(color $RESET)"
		PS1_PRE+="$(color $RESET)"

		PS1_POST="$(color $RESET)"
		PS1_POST+="$(color $FG_CYAN)]$(color $RESET)"
		PS1_POST+=" \$ "
		PS1_POST+="$(color $RESET)"
    fi

	export PS1="${PS1_PRE}${PS1_POST}"
fi;

