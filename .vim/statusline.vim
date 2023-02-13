" .vimrc
" .vim/statusline.vim
" .vim/autoload/sline.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" ----------------------------------------------------------------------
"  Statusline configuration
" ----------------------------------------------------------------------

set statusline=
set statusline+=%m                  " Modified flag: [+] or [-]
set statusline+=%<                  " Truncate if too long
set statusline+=%h%w%q%r            " Flags: Help, Preview, *List, Readonly
set statusline+=%{sline#Icon('\ ','\ ')}
set statusline+=%#StatusLineNormal#   " Start named highlight group
set statusline+=%{sline#Path()}
set statusline+=%*                  " Reset highlight group
" set statusline+=%t                  " File name
set statusline+=%{sline#Filename()}
set statusline+=%{sline#Hunks('\ ')}
set statusline+=\                   " Space
set statusline+=%{sline#Paste()}
set statusline+=%{sline#Spell()}
set statusline+=%=                  " left/right alignment separator
" set statusline+=%<%{sline#Tag('')}\ 
set statusline+=%#StatusLineNormal#   " Start named highlight group
set statusline+=%y                  " Filetype
set statusline+=%*                  " Reset highlight group
set statusline+=%{sline#GitBranch('\ \ \ ')}
set statusline+=\                   " Space
set statusline+=%7.(%l:%c%)         " Line number : Column number
set statusline+=%5p%%               " Percentage through file in lines
set statusline+=\                   " Space

