## FZF - fuzzy finder
#
# Default settings
export FZF_DEFAULT_OPTS=' --multi --filepath-word --info=inline'
export FZF_DEFAULT_OPTS+=' --prompt=\>\>\>\  --marker=+'
export FZF_DEFAULT_OPTS+=" --bind='ctrl-w:backward-kill-word'"
export FZF_DEFAULT_OPTS+=" --bind='ctrl-a:toggle-all'"
export FZF_DEFAULT_OPTS+=" --bind='ctrl-o:toggle-sort'"
export FZF_DEFAULT_OPTS+=" --bind='ctrl-/:toggle-preview'"
export FZF_DEFAULT_OPTS+=' --color=light,hl:6,fg+:regular,bg+:254,hl+:6,'
export FZF_DEFAULT_OPTS+='prompt:regular:130,query:regular,info:4,separator:7,'
export FZF_DEFAULT_OPTS+='pointer:regular:4,marker:bold:1,'
export FZF_DEFAULT_OPTS+='preview-bg:254'

# Use fd as default search; show hidden files, respect .gitignore
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .bzr'


# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" --exclude ".bzr" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" --exclude ".bzr" . "$1"
}

