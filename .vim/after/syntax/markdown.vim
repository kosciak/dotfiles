" .vimrc
" .vim/after/syntax/markdown.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"

" Add highlighting for TODO and NOTE keywords
syn keyword mkdTodo     TODO FIXME XXX NOTE containedin=htmlH[1-6],mkdNonListItemBlock,mkdListItemLine
hi def link mkdTodo             Todo

