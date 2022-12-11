
# Define colors
if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);

	black=$(tput setaf 0);
	red=$(tput setaf 1);
	green=$(tput setaf 2);
	yellow=$(tput setaf 3);
	blue=$(tput setaf 4);
	magenta=$(tput setaf 5);
	cyan=$(tput setaf 6);
	white=$(tput setaf 7);
else
	bold='';
	reset="\\e[0m";

	black="\\e[1;30m";
	red="\\e[1;31m";
	green="\\e[1;32m";
	yellow="\\e[1;33m";
	blue="\\e[1;34m";
	magenta="\\e[1;35m";
	cyan="\\e[1;36m";
	white="\\e[1;37m";
fi;


# Set PS1
if [[ ! -z $BASH ]]; then
    if [[ $EUID -eq 0 ]]; then
		# Logged as root
        PS1="${yellow}[${reset}${red}u@\h${reset} ${yellow}\w${reset}${yellow}]${reset} # "
    else
		# Normal user
        PS1="${cyan}[${reset}${blue}u@\h${reset} ${green}\w${reset}${cyan}]${reset} $ "
    fi
fi

### Change title of terminals
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

