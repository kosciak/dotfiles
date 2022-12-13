
## Define colors and attributes
if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	RESET="\[$(tput sgr0)\]"

	BOLD="\[$(tput bold)\]"
	DIM="\[$(tput dim)\]"
	ITALICS="\[$(tput sitm)\]"
	UNDERLINE="\[$(tput smul)\]"
	INVERT="\[$(tput rev)\]"

	BLACK="\[$(tput setaf 0)\]"
	RED="\[$(tput setaf 1)\]"
	GREEN="\[$(tput setaf 2)\]"
	YELLOW="\[$(tput setaf 3)\]"
	BLUE="\[$(tput setaf 4)\]"
	MAGENTA="\[$(tput setaf 5)\]"
	CYAN="\[$(tput setaf 6)\]"
	WHITE="\[$(tput setaf 7)\]"

	BRIGHT_BLACK="\[$(tput setaf 8)\]"
	BRIGHT_RED="\[$(tput setaf 9)\]"
	BRIGHT_GREEN="\[$(tput setaf 10)\]"
	BRIGHT_YELLOW="\[$(tput setaf 11)\]"
	BRIGHT_BLUE="\[$(tput setaf 12)\]"
	BRIGHT_MAGENTA="\[$(tput setaf 13)\]"
	BRIGHT_CYAN="\[$(tput setaf 14)\]"
	BRIGHT_WHITE="\[$(tput setaf 15)\]"

	BG_BLACK="\[$(tput setab 0)\]"
	BG_RED="\[$(tput setab 1)\]"
	BG_GREEN="\[$(tput setab 2)\]"
	BG_YELLOW="\[$(tput setab 3)\]"
	BG_BLUE="\[$(tput setab 4)\]"
	BG_MAGENTA="\[$(tput setab 5)\]"
	BG_CYAN="\[$(tput setab 6)\]"
	BG_WHITE="\[$(tput setab 7)\]"
else
	RESET="\[\e[0m\]"

	BOLD="\[\e[1m\]"
	DIM="\[\e[2m\]"
	ITALICS="\[\e[3m\]"
	UNDERLINE="\[\e[4m\]"
	INVERT="\[\e[7m\]"

	BLACK="\[\e[30m\]"
	RED="\[\e[31m\]"
	GREEN="\[\e[32m\]"
	YELLOW="\[\e[33m\]"
	BLUE="\[\e[34m\]"
	MAGENTA="\[\e[35m\]"
	CYAN="\[\e[36m\]"
	WHITE="\[\e[37m\]"

	BRIGHT_BLACK="\[\e[90m\]"
	BRIGHT_RED="\[\e[91m\]"
	BRIGHT_GREEN="\[\e[92m\]"
	BRIGHT_YELLOW="\[\e[93m\]"
	BRIGHT_BLUE="\[\e[94m\]"
	BRIGHT_MAGENTA="\[\e[95m\]"
	BRIGHT_CYAN="\[\e[96m\]"
	BRIGHT_WHITE="\[\e[97m\]"

	BG_BLACK="\[\e[40m\]"
	BG_RED="\[\e[41m\]"
	BG_GREEN="\[\e[42m\]"
	BG_YELLOW="\[\e[43m\]"
	BG_BLUE="\[\e[44m\]"
	BG_MAGENTA="\[\e[45m\]"
	BG_CYAN="\[\e[46m\]"
	BG_WHITE="\[\e[47m\]"
fi;


## Set PS* prompts
if [[ ! -z $BASH ]]; then
	PS1="[\u@\h \w] \$"

    if [[ $EUID -eq 0 ]]; then
		# Logged as root
		PS1_PRE="${RESET}"
		# PS1_PRE+="${YELLOW}[${RESET}"
		PS1_PRE+="${BOLD}${RED}\u${RESET}"
		PS1_PRE+="@"
		PS1_PRE+="${RED}\h${RESET}"
		PS1_PRE+=" "
		PS1_PRE+="${YELLOW}\w${RESET}"
		PS1_PRE+="${RESET}"

		PS1_POST="${RESET}"
		# PS1_POST+="${YELLOW}]${RESET}"
		PS1_POST+=" \$ "
		PS1_POST+="${RESET}"
    else
		# Normal user
		PS1_PRE="${RESET}"
		# PS1_PRE+="${CYAN}[${RESET}"
		# PS1_PRE+="${BLUE}\u${RESET}"
		# PS1_PRE+="@"
		# PS1_PRE+="${BLUE}\h${RESET}"
		PS1_PRE+=" "
		PS1_PRE+="${BOLD}${BLUE}\w${RESET}"
		PS1_PRE+="${RESET}"

		PS1_POST="${RESET}"
		# PS1_POST+="${CYAN}]${RESET}"
		PS1_POST+=" \$ "
		PS1_POST+="${RESET}"
    fi

	export PS1="${PS1_PRE}${PS1_POST}"
fi;


__venv_ps1() {
	printf "${MAGENTA} %s${RESET}" "${VIRTUAL_ENV##*/}"
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
		# __git_ps1 "${PS1_PRE}" "${PS1_POST}" " %s"
		__git_ps1 "${PS1_PRE}" "${PS1_POST}" " @%s"
	fi;

	# Add Virtual ENV name to prompt
	if [[ -n "$VIRTUAL_ENV" ]]; then
		PS1="$(__venv_ps1)${PS1}"
	fi;

	export PS1

}
export PROMPT_COMMAND="prompt_command"

