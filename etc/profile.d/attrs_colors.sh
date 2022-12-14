
## Define colors and attributes
#  NOTE: When using in PS1 put inside \[$COLOR\]
if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors

	export BOLD=$(tput bold)
	export DIM=$(tput dim)
	export ITALICS=$(tput sitm)
	export UNDERLINE=$(tput smul)
	export INVERT=$(tput rev)

	export RESET=$(tput sgr0) # Reset ALL attributes
	export NORMAL="\e[22m" # Reset BOLD and DIM
	export RESET_ITALICS=$(tput ritm)
	export RESET_UNDERLINE=$(tput rmul)
	export RESET_INVERT=$(tput ritm)

	export FG_BLACK=$(tput setaf 0)
	export FG_RED=$(tput setaf 1)
	export FG_GREEN=$(tput setaf 2)
	export FG_YELLOW=$(tput setaf 3)
	export FG_BLUE=$(tput setaf 4)
	export FG_MAGENTA=$(tput setaf 5)
	export FG_CYAN=$(tput setaf 6)
	export FG_WHITE=$(tput setaf 7)

	export FG_LIGHT_BLACK=$(tput setaf 8)
	export FG_LIGHT_RED=$(tput setaf 9)
	export FG_LIGHT_GREEN=$(tput setaf 10)
	export FG_LIGHT_YELLOW=$(tput setaf 11)
	export FG_LIGHT_BLUE=$(tput setaf 12)
	export FG_LIGHT_MAGENTA=$(tput setaf 13)
	export FG_LIGHT_CYAN=$(tput setaf 14)
	export FG_LIGHT_WHITE=$(tput setaf 15)

	export BG_BLACK=$(tput setab 0)
	export BG_RED=$(tput setab 1)
	export BG_GREEN=$(tput setab 2)
	export BG_YELLOW=$(tput setab 3)
	export BG_BLUE=$(tput setab 4)
	export BG_MAGENTA=$(tput setab 5)
	export BG_CYAN=$(tput setab 6)
	export BG_WHITE=$(tput setab 7)

	export BG_LIGHT_BLACK=$(tput setab 8)
	export BG_LIGHT_RED=$(tput setab 9)
	export BG_LIGHT_GREEN=$(tput setab 10)
	export BG_LIGHT_YELLOW=$(tput setab 11)
	export BG_LIGHT_BLUE=$(tput setab 12)
	export BG_LIGHT_MAGENTA=$(tput setab 13)
	export BG_LIGHT_CYAN=$(tput setab 14)
	export BG_LIGHT_WHITE=$(tput setab 15)
else
	export BOLD="\e[1m"
	export DIM="\e[2m"
	export ITALICS="\e[3m"
	export UNDERLINE="\e[4m"
	export INVERT="\e[7m"

	export RESET="\e[0m" # Reset ALL attributes
	export NORMAL="\e[22m" # Reset BOLD and DIM
	export RESET_ITALICS="\e[23m"
	export RESET_UNDERLINE="\e[24m"
	export RESET_INVERT="\e[27m"

	export FG_BLACK="\e[30m"
	export FG_RED="\e[31m"
	export FG_GREEN="\e[32m"
	export FG_YELLOW="\e[33m"
	export FG_BLUE="\e[34m"
	export FG_MAGENTA="\e[35m"
	export FG_CYAN="\e[36m"
	export FG_WHITE="\e[37m"

	export FG_LIGHT_BLACK="\e[90m"
	export FG_LIGHT_RED="\e[91m"
	export FG_LIGHT_GREEN="\e[92m"
	export FG_LIGHT_YELLOW="\e[93m"
	export FG_LIGHT_BLUE="\e[94m"
	export FG_LIGHT_MAGENTA="\e[95m"
	export FG_LIGHT_CYAN="\e[96m"
	export FG_LIGHT_WHITE="\e[97m"

	export BG_BLACK="\e[40m"
	export BG_RED="\e[41m"
	export BG_GREEN="\e[42m"
	export BG_YELLOW="\e[43m"
	export BG_BLUE="\e[44m"
	export BG_MAGENTA="\e[45m"
	export BG_CYAN="\e[46m"
	export BG_WHITE="\e[47m"

	export BG_LIGHT_BLACK="\e[100m"
	export BG_LIGHT_RED="\e[101m"
	export BG_LIGHT_GREEN="\e[102m"
	export BG_LIGHT_YELLOW="\e[103m"
	export BG_LIGHT_BLUE="\e[104m"
	export BG_LIGHT_MAGENTA="\e[105m"
	export BG_LIGHT_CYAN="\e[106m"
	export BG_LIGHT_WHITE="\e[107m"
fi;

