" .vim/autoload/statusline.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"


function! statusline#Path()
  let path = substitute(expand('%:h'), '^\.$', '', 'i')
  if strlen(path) == 0
    return ''
  elseif path[0] ==# '/' || path[0:2] ==# '../'
    return expand('%:~:h') .. '/'
  else
    return path .. '/'
  endif
endfunc


function! statusline#Icon()
  return WebDevIconsGetFileTypeSymbol()
endfunc


function! statusline#Git()
  let branch = FugitiveHead()
  if strlen(branch) > 0
    return ' ' .. branch .. '%* '
  else
    return ''
  endif
endfunc


function! statusline#Tag()
  " let tag = tagbar#currenttag(' %s', '', 'f')
  let tag = tagbar#currenttag(' %s', '')
  if strlen(tag) > 0
    return tag
  else
    return ''
  endif
endfunc

