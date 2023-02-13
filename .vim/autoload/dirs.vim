" .vimrc
" .vim/autoload/dirs.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"

function! dirs#RelativeTo(path, dir) abort
  let dir = a:dir
  let path = a:path

  if path[0] != '/'
    let path = fnamemodify(path, ':p')
  endif

  if path[0:strlen(dir)-1] ==# dir
    let path = path[strlen(dir)+1:]
  else
    let path = fnamemodify(path, ':~')
  endif

  return path
endfunc


function! dirs#RelativeToCWD(path) abort
  return dirs#RelativeTo(a:path, getcwd())
endfunc


function! dirs#RelativeToRoot(path) abort
  return dirs#RelativeTo(a:path, dirs#RootDir())
endfunc


function! dirs#Dir(...) abort
  let path = a:0 > 0 ? fnamemodify(a:1, ':p') : expand('%:p')
  if isdirectory(path)
    return path
  else
    return fnamemodify(path, ':h')
  endif
endfunc


function! dirs#CWD() abort
  return getcwd()
endfunc


function! dirs#RootDir() abort
  if exists('*FindRootDirectory')
    let dir = FindRootDirectory()
  else
    let dir = ''
  endif
  return dir
endfunc


function! dirs#WikiRootDir() abort
  if exists(':WikiIndex')
    let dir = wiki#get_root()
  else
    let dir = ''
  endif
  return dir
endfunc


function! dirs#ProjectsDir() abort
  if strlen($PROJECT_HOME)
    let dir = fnamemodify($PROJECT_HOME, ':p')
  else
    let dir = ''
  endif
  return dir
endfunc

