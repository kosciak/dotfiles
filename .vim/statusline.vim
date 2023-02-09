" .vimrc
" .vim/statusline.vim
" .vim/autoload/statusline.vim
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
set statusline+=%{statusline#Icon('\ ','\ ')}
set statusline+=%#StatusLineNormal#   " Start named highlight group
set statusline+=%{statusline#Path()}
set statusline+=%*                  " Reset highlight group
" set statusline+=%t                  " File name
set statusline+=%{statusline#Filename()}
set statusline+=%{statusline#Hunks('\ ')}
set statusline+=\                   " Space
set statusline+=%{statusline#Paste()}
set statusline+=%{statusline#Spell()}
set statusline+=%=                  " left/right alignment separator
" set statusline+=%<%{statusline#Tag('')}\ 
set statusline+=%#StatusLineNormal#   " Start named highlight group
set statusline+=%y                  " Filetype
set statusline+=%*                  " Reset highlight group
set statusline+=%{statusline#GitBranch('\ \ \ ')}
set statusline+=\                   " Space
set statusline+=%7.(%l:%c%)         " Line number : Column number
set statusline+=%5p%%               " Percentage through file in lines
set statusline+=\                   " Space

