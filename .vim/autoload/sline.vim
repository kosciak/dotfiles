" .vimrc
" .vim/autoload/sline.vim
" .vim/autoload/dirs.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" ----------------------------------------------------------------------
"  sline - Simple Statusline
" ----------------------------------------------------------------------

function! sline#Format(txt, args) abort
  let before  = len(a:args) > 0 ? a:args[0] : ''
  let after   = len(a:args) > 1 ? a:args[1] : ''

  if before[0] == ' '
    " NOTE: There's some strange bug in statusline parsing:
    " If value returned from %{function()} starts with space, depending of
    " preceding characters it MIGHT or MIGHT NOT be omitted
    " So sometimes you would need one space, sometimes two spaces to show only
    " one space...
    " To fix this let's replace first space with \u00a0 - no-break space
    let before = ' ' .. before[1:]
  endif

  if strlen(a:txt) == 0
    return ''
  else
    return before .. a:txt .. after
  endif
endfunc


function! sline#GetPath(...) abort
  let path = dirs#RelativeTo(dirs#Dir(), dirs#CWD())

  if strlen(path) == 0
    return ''
  else
    return path .. '/'
  endif
endfunc

function! sline#Path(...) abort
  let path = sline#GetPath()
  return sline#Format(path, a:000)
endfunc


function! sline#Filename(...) abort
  let file = expand('%:t')
  return sline#Format(file, a:000)
endfunc


function! sline#Icon(...) abort
  if exists('*WebDevIconsGetFileTypeSymbol')
    " Requires: ryanoasis/vim-devicons
    let icon = WebDevIconsGetFileTypeSymbol()
  elseif exists('*nerdfont#find')
    " Requires: lambdalisue/nerdfont.vim
    let icon = nerdfont#find()
  else
    let icon = ''
  endif
  return sline#Format(icon, a:000)
endfunc


function! sline#GitBranch(...) abort
  if exists('*FugitiveHead')
    " Requires: tpope/vim-fugitive
    let branch = FugitiveHead()
  else
    let branch = ''
  endif
  return sline#Format(branch, a:000)
endfunc


function! sline#Hunks(...) abort
  if exists('*sy#repo#get_stats_decorated')
    " Requires: mhinz/vim-signify
    let hunks = sy#repo#get_stats_decorated()
  elseif exists('*GitGutterGetHunkSummary')
    " Requires: airblade/vim-gitgutter
    let hunks = ''
    let [a,m,r] = GitGutterGetHunkSummary()
    if a
      let hunks = hunks .. ' ' .. printf('+%d', a)
    endif
    if r
      let hunks = hunks .. ' ' .. printf('-%d', r)
    endif
    if m
      let hunks = hunks .. ' ' .. printf('~%d', m)
    endif
    if hunks[0] == ' '
      let hunks = hunks[1:]
    endif
    if strlen(hunks)
      let hunks = '[' .. hunks .. ']'
    endif
  else
    let hunks = ''
  endif
  return sline#Format(hunks, a:000)
endfunc


function! sline#Paste(...) abort
  let option = &paste ? '[paste]' : ''
  return sline#Format(option, a:000)
endfunc


function! sline#Spell(...) abort
  let lang = &spelllang
  let option = &spell ? '[spell:'..lang..']' : ''
  return sline#Format(option, a:000)
endfunc


function! sline#Tag(flags, ...) abort
  if exists('*tagbar#currenttag')
    " Requires: preservim/tagbar
    let tag = tagbar#currenttag('%s', a:flags)
  else
    let tag = ''
  endif
  return sline#Format(tag, a:000)
endfunc

