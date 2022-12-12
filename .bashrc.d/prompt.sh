
## Define colors and attributes
if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	BOLD="\[$(tput bold)\]"
	RESET="\[$(tput sgr0)\]"

	BLACK="\[$(tput setaf 0)\]"
	RED="\[$(tput setaf 1)\]"
	GREEN="\[$(tput setaf 2)\]"
	YELLOW="\[$(tput setaf 3)\]"
	BLUE="\[$(tput setaf 4)\]"
	MAGENTA="\[$(tput setaf 5)\]"
	CYAN="\[$(tput setaf 6)\]"
	WHITE="\[$(tput setaf 7)\]"
else
	BOLD="\[\e[1m\]"
	RESET="\[\e[0m\]"

	BLACK="\[\e[30m\]"
	RED="\[\e[31m\]"
	GREEN="\[\e[32m\]"
	YELLOW="\[\e[33m\]"
	BLUE="\[\e[34m\]"
	MAGENTA="\[\e[35m\]"
	CYAN="\[\e[36m\]"
	WHITE="\[\e[37m\]"
fi;


## Set PS* prompts
if [[ ! -z $BASH ]]; then
    if [[ $EUID -eq 0 ]]; then
		# Logged as root
        PS1_PRE="${YELLOW}[${RESET}"
		PS1_PRE+="${RED}\u${RESET}"
		PS1_PRE+="@"
		PS1_PRE+="${RED}\h${RESET}"
		PS1_PRE+=" "
		PS1_PRE+="${YELLOW}\w${RESET}"
		PS1_POST="${YELLOW}]${RESET}"
		PS1_POST+=" \$ "
    else
		# Normal user
        PS1_PRE="${CYAN}[${RESET}"
		PS1_PRE+="${BLUE}\u${RESET}"
		PS1_PRE+="@"
		PS1_PRE+="${BLUE}\h${RESET}"
		PS1_PRE+=" "
		PS1_PRE+="${GREEN}\w${RESET}"
		PS1_POST="${CYAN}]${RESET}"
		PS1_POST+=" \$ "
    fi
	export PS1
fi;


PS1_GIT_PROMPT_FORMAT=" (%s)"
PS1_VENV_PROMPT_FORMAT="(%s) "


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

	PS1="${PS1_PRE}${PS1_POST}"

	# Add git prompt if available
	# NOTE: git-prompt coloring works only when called from PROMPT_COMMAND
	# NOTE: It will replace PS1 with new value!
	if type __git_ps1 &> /dev/null; then
		__git_ps1 "${PS1_PRE}" "${PS1_POST}" "${PS1_GIT_PROMPT_FORMAT}"
	fi;

	# Add Virtual ENV name to prompt
	if [[ -n "$VIRTUAL_ENV" ]]; then
		PS1_VENV=$(printf "${PS1_VENV_PROMPT_FORMAT}" "$(basename $VIRTUAL_ENV)")
		PS1="${PS1_VENV}${PS1}"
	fi;

	export PS1

	# Support OSC7 for VTE-based terminals (e.g. tilix) if existing
	# See: /etc/profile.d/vte.sh
	# NOTE: In gnome-terminal allows opening new tabs in current working dir
	hash __vte_osc7 &> /dev/null && __vte_osc7

}
export PROMPT_COMMAND="prompt_command"

