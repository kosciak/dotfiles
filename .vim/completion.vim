" .vimrc
" .vim/completion.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" ----------------------------------------------------------------------
"  Command line and wildmenu completion
" ----------------------------------------------------------------------

" Command line and wildmenu settings
set wildmode=longest,full

" Use popup menu if available
if v:version >= 900
  " set wildoptions=fuzzy
  set wildoptions=pum
endif


" ----------------------------------------------------------------------
"  Insert mode completion
"   - show menu popup even for single match
"   - only insert longest common text for matches
"   - no preview or popup
" ----------------------------------------------------------------------
if exists('s:override_completeopt') == 0
  set completeopt=menuone,longest
endif

" NOTE: YCM changes 'menu' to 'menuone' and removes 'longest'
"       https://github.com/ycm-core/YouCompleteMe/issues/562
"       Well... completeopt has global scope so that sucks when you want to 
"       use completion in files where YCM is not running

" Let's store original completeopt value
let s:override_completeopt = &completeopt
let s:restore_completeopt = &completeopt

" When overriding completeopt let's store previous value
function! s:overrideCompleteopt() abort
  if exists("g:loaded_youcompleteme") && has_key(g:ycm_filetype_blacklist, &ft)
    let s:restore_completeopt = &completeopt
    let &completeopt = s:override_completeopt
  endif
endfunc

" Restore previous value so YCM can work correctly
function! s:restoreCompleteopt() abort
  if exists("g:loaded_youcompleteme") && has_key(g:ycm_filetype_blacklist, &ft)
    let &completeopt = s:restore_completeopt
  endif
endfunc

" Override completeopt only when in Insert mode
augroup RestoreCompleteopt
  au!
  autocmd InsertEnter * call s:overrideCompleteopt()
  autocmd InsertLeave * call s:restoreCompleteopt()
augroup END

