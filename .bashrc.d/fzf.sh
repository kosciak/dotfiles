## FZF - fuzzy finder
#
# See: https://github.com/junegunn/fzf
# See: https://wiki.archlinux.org/title/Fzf
#

# Default settings
# TODO: Revise with latest versions
# TODO: Move options to .fzfrc ?
export FZF_DEFAULT_OPTS=' --ansi --multi --filepath-word --info=inline'
export FZF_DEFAULT_OPTS+=' --prompt=\>\>\>\  --marker=+'
export FZF_DEFAULT_OPTS+=" --bind='ctrl-w:backward-kill-word'"
export FZF_DEFAULT_OPTS+=" --bind='ctrl-a:toggle-all'"
export FZF_DEFAULT_OPTS+=" --bind='ctrl-o:toggle-sort'"
export FZF_DEFAULT_OPTS+=" --bind='ctrl-/:toggle-preview'"
export FZF_DEFAULT_OPTS+=" --bind='ctrl-y:toggle-preview'"
export FZF_DEFAULT_OPTS+=' --color=light,hl:6,fg+:regular,bg+:254,hl+:6,'
export FZF_DEFAULT_OPTS+='prompt:regular:130,query:regular,info:4,separator:7,'
export FZF_DEFAULT_OPTS+='pointer:regular:4,marker:bold:1,'
export FZF_DEFAULT_OPTS+='preview-bg:254'

# # Full initialization (completion and key bindings)
# if [ -f "/usr/bin/fzf" ]; then
#     eval "$(fzf --bash)"
# fi
# # Initialization of key bindings only
# # NOTE: completion is installed by default!
# source /usr/share/fzf/shell/key-bindings.bash

# Completion options
# export FZF_COMPLETION_TRIGGER=**
export FZF_COMPLETION_TRIGGER=**
export FZF_COMPLETION_OPTS="--no-multi --bind='tab:accept'"

# Use fd as default search; show hidden files, respect .gitignore
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude .bzr'

# # Options for path completion (e.g. vim **<TAB>)
# export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'

# # Options for directory completion (e.g. cd **<TAB>)
# export FZF_COMPLETION_DIR_OPTS='--walker dir,follow,hidden'

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

# TODO: Consider using bfs instead of fd
#       Breadth-first search, supposedly faster than fd
#       https://github.com/tavianator/bfs/discussions/119
#       https://github.com/junegunn/fzf/wiki/Examples-(completion)#bash-use-bfs-instead-of-fd-for-more-ergonomic-results
#       NOTE: No option to ignore .gitignore settings

