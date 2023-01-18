## Setup git-prompt

# GIT_PS1 settings
export GIT_PS1_HIDE_IF_PWD_IGNORED=1

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=''
# export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_COMPRESSSPARSESTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCONFLICTSTATE="yes"

# export GIT_PS1_STATESEPARATOR=':'
export GIT_PS1_STATESEPARATOR=''

# export GIT_PS1_DESCRIBE_STYLE='describe'
export GIT_PS1_DESCRIBE_STYLE='contains'

export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWCOLORHINTS=''


# Custom GIT_PS1 settings
export GIT_PS1_STATEBEFORENAME=1

# NOTE: Using na-fs-*circle* icons:
#                 
# Other characters thath might be useful:
#  - circles: ○ ● ⭘ ⬤j
#  - arrows:   🡑 🡓 🡩 🡫 🡱 🡳 🡅 🡇 🠭🠯 
export GIT_PS1_CONFLICT="$(color $FG_RED)"
export GIT_PS1_NO_DIVERGENCE="" # Don't show anything
export GIT_PS1_BEHIND="$(color $FG_RED)"
export GIT_PS1_AHEAD="$(color $FG_LIGHT_BLUE)"
export GIT_PS1_INIT="$(color $FG_BLUE)" #""
export GIT_PS1_UNTRACKED="$(color $FG_RED)"
export GIT_PS1_MODIFIED="$(color $FG_YELLOW)" #"" ""
export GIT_PS1_STAGED="$(color $FG_GREEN)" #""
export GIT_PS1_STASHED="$(color $FG_MAGENTA)" #"

export GIT_PS1_STATESEPARATOR=" $(color $FG_GREEN)"


# Source if present
if ! type __git_ps1 &> /dev/null && [ -e /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
	. /usr/share/git-core/contrib/completion/git-prompt.sh
fi


# Custom implementation, mostly compatible with original one
# Some things might be ommited though
# TODO: Consider replacing just __git_ps1_colorize_gitstring function?
# 		But there are also some changes in order of state flags
__git_ps1 () {

	# Default state values like in original __git_ps1
	local CONFLICT="|CONFLICT"
	local NO_DIVERGENCE="="
	local BEHIND="<"
	local AHEAD=">"
	local INIT="#"
	local UNTRACKED="%"
	local MODIFIED="*"
	local STAGED="+"
	local STASHED="$"

	local exit=$?
	local pcmode=yes
	local detached=no
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

	if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" == "yes" ]] &&
	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
		conflict=$GIT_PS1_CONFLICT || $CONFLICT
	fi

	# NOTE: keep variable names same, so it would be possible to call __git_ps1_colorize_gitstring
	local c='' # is bare repo
	local b='' # branch name

	local detached="no"

	local conflict=""
	local w="" # modified
	local i="" # staged or init
	local s="" # stashed
	local u="" # untracked
	local h="" # sparse state # TODO: !
	local p="" # short version of upstream state indicator
	local upstream="" # verbose version of upstream state indicator

	b="$(git name-rev --name-only --no-undefined --always HEAD 2>/dev/null)"
	if [ -z "$name" ]; then
		local symbolic_ref="$(git symbolic-ref -q HEAD 2>/dev/null)"
		b=${symbolic_ref##refs/heads/}
	fi

	if [ "true" = "$inside_gitdir" ]; then
		if [ "true" = "$bare_repo" ]; then
			c="BARE:"
		else
			b="GIT_DIR!"
		fi
	elif [ "true" = "$inside_worktree" ]; then
		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
			[ "$(git config --bool bash.showDirtyState)" != "false" ]
		then
			git diff --no-ext-diff --quiet || w=${GIT_PS1_MODIFIED-$MODIFIED}
			git diff --no-ext-diff --cached --quiet || i=${GIT_PS1_STAGED-$STAGED}
			if [ -z "$short_sha" ] && [ -z "$i" ]; then
				i=${GIT_PS1_INIT-$INIT}
			fi
		fi

		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
			git rev-parse --verify --quiet refs/stash >/dev/null
		then
			s=${GIT_PS1_STASHED-$STASHED}
		fi

		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
			[ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
			git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/null
		then
			u=${GIT_PS1_UNTRACKED-$UNTRACKED}
		fi

		# TODO: Sparse-checkout

		if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
			local count="$(git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)"
			if [ -n "${count}" ]; then
				case "$count" in
				"") # no upstream
					p="" ;;
				"0	0") # equal to upstream
					p=${GIT_PS1_NO_DIVERGENCE-$NO_DIVERGENCE} ;;
				"0	"*) # ahead of upstream
					p=${GIT_PS1_AHEAD-$AHEAD} ;;
				*"	0") # behind upstream
					p=${GIT_PS1_BEHIND-$BEHIND} ;;
				*)		# diverged from upstream
					p=${GIT_PS1_BEHIND-$BEHIND}
					p+=${GIT_PS1_AHEAD-$AHEAD} ;;
				esac
			fi
		fi
	fi

	if type __git_ps1 &> /dev/null &&
	   [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
		__git_ps1_colorize_gitstring
	fi

	local name="${c}${b}"
	# NOTE: Original __git_ps1 uses different order:
	# 	local f="$h$w$i$s$u$p"
	local state="${p}${s}${u}${w}${i}${conflict}"
	local separator="${GIT_PS1_STATESEPARATOR-" "}"

	# local printf_vars="${printf_format//[^%]}"
	# local printf_vars_count=${#printf_vars}

	local gitstring="${name}${state:+$separator$state}"
	if [ -n "${state-}" ] && [ -n "${GIT_PS1_STATEBEFORENAME-}" ]; then
		gitstring="${state}${state:+$separator$name}"
	fi

	printf -v gitstring -- "$printf_format" "$gitstring"
	PS1="$ps1pc_start$gitstring$ps1pc_end"

	return $exit
}

