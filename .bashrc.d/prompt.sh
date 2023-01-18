
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
		# PS1_PRE+="$(color $FG_YELLOW)[$(color $RESET)"
		PS1_PRE+="$(color $BOLD)$(color $FG_RED)\u$(color $RESET)"
		PS1_PRE+="@"
		PS1_PRE+="$(color $FG_RED)\h$(color $RESET)"
		PS1_PRE+=" "
		PS1_PRE+="$(color $FG_YELLOW)\w$(color $RESET)"
		PS1_PRE+="$(color $RESET)"

		PS1_POST="$(color $RESET)"
		# PS1_POST+="$(color $FG_YELLOW)]$(color $RESET)"
		PS1_POST+=" \$ "
		PS1_POST+="$(color $RESET)"
    else
		# Normal user
		PS1_PRE="$(color $RESET)"
		# PS1_PRE+="$(color $FG_CYAN)[$(color $RESET)"
		# PS1_PRE+="$(color $FG_BLUE)\u$(color $RESET)"
		# PS1_PRE+="@"
		# PS1_PRE+="$(color $FG_BLUE)\h$(color $RESET)"
		PS1_PRE+=" "
		# PS1_PRE+="$(color $BOLD)$(color $FG_LIGHT_BLUE) \w$(color $RESET)"
		PS1_PRE+="$(color $BOLD)$(color $FG_LIGHT_BLUE)\w$(color $RESET)"
		PS1_PRE+="$(color $RESET)"

		PS1_POST="$(color $RESET)"
		# PS1_POST+="$(color $FG_CYAN)]$(color $RESET)"
		# PS1_POST+=" ❯ "
		PS1_POST+=" $(color $FG_LIGHT_BLACK)$(color $BOLD)\$$(color $RESET) "
		PS1_POST+="$(color $RESET)"
    fi

	export PS1="${PS1_PRE}${PS1_POST}"

	export PS2="$(color $FG_LIGHT_BLACK)$(color $BOLD)> $(color $RESET)"
fi;


__venv_ps1() {
	# printf "$(color $RESET)$(color $BG_WHITE)$(color $FG_MAGENTA) %s $(color $FG_LIGHT_WHITE)◢$(color $RESET)" "${VIRTUAL_ENV##*/}"
	printf "$(color $RESET)$(color $FG_MAGENTA) %s$(color $RESET)" \
		"${VIRTUAL_ENV##*/}"
}


## Set PROMPT_COMMAND
#  Executed before PS*
prompt_command() {

	# Change title of terminals
	case ${TERM} in
		xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
			echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"
			;;
		screen*)
			echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"
			;;
	esac;

	# Support OSC7 for VTE-based terminals (e.g. tilix) if existing
	# See: /etc/profile.d/vte.sh
	# NOTE: In gnome-terminal allows opening new tabs in current working dir
	hash __vte_osc7 &> /dev/null && __vte_osc7

	# Set PS* prompts
	PS1="${PS1_PRE}${PS1_POST}"

	# Add git prompt if available
	# NOTE: git-prompt coloring works only when called from PROMPT_COMMAND
	# NOTE: It will replace PS1 with new value!
	if type __git_ps1 &> /dev/null; then
		# __git_ps1 "${PS1_PRE}" "${PS1_POST}" " @%s"
		# __git_ps1 "${PS1_PRE}" "${PS1_POST}" " $(color $FG_GREEN) %s"
		__git_ps1 \
			"${PS1_PRE}" "${PS1_POST}" \
			" $(color $FG_GREEN) %s"
	fi;

	# Add Virtual ENV name to prompt
	if [[ -n "$VIRTUAL_ENV" ]]; then
		PS1="$(__venv_ps1)${PS1}"
	fi;

	export PS1

}
export PROMPT_COMMAND="prompt_command"

