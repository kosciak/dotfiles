" .vimrc
" .vim/ftplugin/help.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"

" Jump to subject under cursor
nnoremap <buffer> <CR> <C-]>
" Back to previous subject
nnoremap <buffer> <BS> <C-T>

" Find next / previous option
nnoremap <buffer> o /'\l\{2,\}'<CR>:noh<CR>
nnoremap <buffer> O ?'\l\{2,\}'<CR>:noh<CR>

" Find next / previous subject
nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>:noh<CR>
nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>:noh<CR>

