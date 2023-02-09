" .vimrc
" .vim/cursorline.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" ----------------------------------------------------------------------
"  Cursorline configuration
" ----------------------------------------------------------------------

" Highlight current line
set cursorline
" with only line number when editing
set cursorlineopt=number

" ... EXCEPT selected FileTypes
let s:cursorlineopt_both = [
      \ 'bufexplorer',
      \ 'tagbar',
      \ 'nerdtree',
      \ 'ctrlp',
      \ 'ctrlsf',
      \ 'help',
      \ 'qf',
      \]

function! s:setCursorlineopt() abort
  " TODO: Maybe just check if &number is set?
  if index(s:cursorlineopt_both, &ft) < 0
    set cursorlineopt=number
  else
    set cursorlineopt=both
  endif
endfunc

augroup SpecialCursorlineopt
  au!

  autocmd FileType * call s:setCursorlineopt()

augroup END

