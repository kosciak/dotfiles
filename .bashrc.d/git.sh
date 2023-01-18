## Setup git-prompt

# Source if present
if ! type __git_ps1 &> /dev/null && [ -e /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
	. /usr/share/git-core/contrib/completion/git-prompt.sh
fi

# Set options
export GIT_PS1_HIDE_IF_PWD_IGNORED=1

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=''
# export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_COMPRESSSPARSESTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCONFLICTSTATE="yes"

# export GIT_PS1_STATESEPARATOR=':'
export GIT_PS1_STATESEPARATOR=' '

# export GIT_PS1_DESCRIBE_STYLE='describe'
export GIT_PS1_DESCRIBE_STYLE='contains'

export GIT_PS1_SHOWCOLORHINTS=1

export GIT_PS1_STATEBEFORENAME=1


__git_custom_ps1 () {

	# local EMPTY_CIRCLE="○"
	# local FULL_CIRCLE="●"
	# local EMPTY_CIRCLE="⭘"
	# local FULL_CIRCLE="⬤"
	# local UP_ARROW=""
	# local DOWN_ARROW=""
	local EMPTY_CIRCLE=""
	local FULL_CIRCLE=""
	local UP_ARROW=""
	local DOWN_ARROW=""

	local BEHIND="$(color $FG_RED)${DOWN_ARROW}"
	local AHEAD="$(color $FG_LIGHT_BLUE)${UP_ARROW}"
	local INIT="$(color $FG_BLUE)${EMPTY_CIRCLE}"
	local UNTRACKED="$(color $FG_RED)"
	local MODIFIED="$(color $FG_YELLOW)${FULL_CIRCLE}" #""
	local STAGED="$(color $FG_GREEN)${FULL_CIRCLE}" #""
	local STASHED="$(color $FG_MAGENTA)"

	local exit=$?
	local ps1pc_start="$1"
	local ps1pc_end="$2"
	local printf_format="${3:-$printf_format}"
	# set PS1 to a plain prompt so that we can
	# simply return early if the prompt should not
	# be decorated
	PS1="$ps1pc_start$ps1pc_end"

	local repo_info rev_parse_exit_code
	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
		--is-bare-repository --is-inside-work-tree \
		--short HEAD 2>/dev/null)"
	rev_parse_exit_code="$?"

	if [ -z "$repo_info" ]; then
		return $exit
	fi

	local short_sha=""
	if [ "$rev_parse_exit_code" = "0" ]; then
		short_sha="${repo_info##*$'\n'}"
		repo_info="${repo_info%$'\n'*}"
	fi
	local inside_worktree="${repo_info##*$'\n'}"
	repo_info="${repo_info%$'\n'*}"
	local bare_repo="${repo_info##*$'\n'}"
	repo_info="${repo_info%$'\n'*}"
	local inside_gitdir="${repo_info##*$'\n'}"
	local git_dir="${repo_info%$'\n'*}"

	if [ "true" = "$inside_worktree" ] &&
	   [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED-}" ] &&
	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
	   git check-ignore -q .
	then
		return $exit
	fi

	local conflict=""
	if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" == "yes" ]] &&
	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
		conflict="true"
	fi

	local bare=''
	local name="$(git name-rev --name-only --no-undefined --always HEAD 2>/dev/null)"
	if [ -z "$name" ]; then
		local symbolic_ref="$(git symbolic-ref -q HEAD 2>/dev/null)"
		name=${symbolic_ref##refs/heads/}
	fi

	local behind=''
	local ahead=''
	local untracked=''
	local modified=''
	local staged=''
	local init=''
	local stashed=''

	if [ "true" = "$inside_gitdir" ]; then
		if [ "true" = "$bare_repo" ]; then
			bare="BARE:"
		else
			name="GIT_DIR!"
		fi
	elif [ "true" = "$inside_worktree" ]; then
		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
			[ "$(git config --bool bash.showDirtyState)" != "false" ]
		then
			git diff --no-ext-diff --quiet || modified=$MODIFIED
			git diff --no-ext-diff --cached --quiet || staged=$STAGED
			if [ -z "$short_sha" ] && [ -z "$staged" ]; then
				init=$INIT
			fi
		fi

		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
			git rev-parse --verify --quiet refs/stash >/dev/null
		then
			stashed=$STASHED
		fi

		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
			[ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
			git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/null
		then
			untracked=$UNTRACKED;
		fi

		# TODO: Sparse-checkout

		if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
			local count="$(git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)"
			if [ -n "${count}" ]; then
				case "$count" in
				"") # no upstream
					;;
				"0	0") # equal to upstream
					;;
				"0	"*) # ahead of upstream
					ahead=$AHEAD ;;
				*"	0") # behind upstream
					behind=$BEHIND ;;
				*)		# diverged from upstream
					ahead=$AHEAD; behind=$BEHIND ;;
				esac
			fi
		fi

	fi

	name="${bare}${name}"
	local state="${init}${behind}${ahead}${stashed}${untracked}${modified}${staged}"
	local gitstring="${name}"

	if [ -n "${state}" ]; then
		if [ -n "${GIT_PS1_STATEBEFORENAME-}" ]; then
			local gitstring="${state}${GIT_PS1_STATESEPARATOR}$(color $FG_GREEN)${name}"
		else
			local gitstring="${name}${GIT_PS1_STATESEPARATOR}${state}"
		fi
	fi
	printf -v gitstring -- "$printf_format" "$gitstring"

	PS1="$ps1pc_start$gitstring$ps1pc_end"
	return $exit
}

