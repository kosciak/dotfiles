" .vimrc
" .gvimrc
" .vim/term.vim
" .vim/statusline.vim
" .vim/cursorline.vim
" .vim/completion.vim
" .vim/plug.vim
" .vim/plugins.vim
" .vim/plugins-obsolete.vim
" .vim/highlights.vim
" .vim/mappings.vim
" .vim/autoload/dirs.vim
" .vim/autoload/sline.vim
" .vim/autoload/syntax.vim
" .vim/ftplugin/mediawiki.vim
" .vim/ftplugin/help.vim
" .vim/after/syntax/markdown.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" ----------------------------------------------------------------------
"  General settings
" ----------------------------------------------------------------------

if v:progname =~? "evim"
  finish
endif

set nocompatible    " Vim setings

set history=1000    " keep 1000 lines of command line history

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif

" Files to ignore
set wildignore+=*~
set wildignore+=*.pyc,*.pyo
set wildignore+=.git,.git/*
set wildignore+=.bzr,.bzr/*
set wildignore+=.svn,.svn/*
set wildignore+=.hg,.hg/*
set wildignore+=__pycache__,*/__pycache__/*

set encoding=utf-8  " UTF-8 by default

set nomodeline      " Disable modeline magic settings

set updatetime=100  " Better performance of vim-signify, YCM, and others

set magic           " magic on for regular expressions

" Terminal and escape sequences settings and fixes
" NOTE: Must be set BEFORE setting colorscheme!
source ~/.vim/term.vim


" ----------------------------------------------------------------------
"  Interface
" ----------------------------------------------------------------------

" Use English for everything in Vim
function! s:setLanguage() abort
  silent exec 'language en_US.utf8'
endfunc
call s:setLanguage()

set title           " set window title

" Remove pipes | that act as seperators on splits
set fillchars+=vert:\ 

set showcmd         " display incomplete commands

if &t_Co > 2 || has("gui_running")
  set hlsearch      " highlight the last used search pattern.
endif

set ignorecase      " ignore case when searching
set smartcase       " override ignorecase when Uppercase in search pattern

set number          " show line numbers
set numberwidth=5   " mininal number of columns for line numbers

set wrap
set linebreak
" Column used for number will be used fot text of wrapped lines
set cpoptions+=n    
" String to put at the start of wrapped lines
" NOTE: Keep it in sync with numberwidth
set showbreak=>>>>\ 

" NOTE: Needs 'set list' to work and show listchars!
set listchars=tab:→\ ,eol:¶,extends:→,precedes:<,trail:·,nbsp:°

set scrolloff=3     " let X lines before/after cursor during scroll

"set foldcolumn=1    " extra margin to the left

if has('conceal')
  set conceallevel=2
endif

" set colorcolumn=+1  " Highlight column after textwidth (if set)

set showmatch       " show matching brackets

" Statusline
source ~/.vim/statusline.vim

" Cursorline
source ~/.vim/cursorline.vim

" Command line and Insert mode completion
source ~/.vim/completion.vim


" ----------------------------------------------------------------------
"  Editing
" ----------------------------------------------------------------------

set tabstop=4       " 4 whitespaces for tabs visual presentation 
set shiftwidth=4    " shift lines by 4 spaces
set shiftround      " round indent to multiple of shiftwidth
set expandtab       " expand tabs into spaces

set autoindent      " indent when moving to the next line
set smartindent     " smart autoindenting when starting new line

" Spellchecking: English and Polish, show 10 best suggestions
set spelllang=en,pl
set spellsuggest=best,10

set dictionary+=/usr/share/dict/words


" ----------------------------------------------------------------------
"  Windows, tabs, buffers
" ----------------------------------------------------------------------

set hidden          " allow closing of windows with unsaved buffers


" ----------------------------------------------------------------------
"  Autocommands
" ----------------------------------------------------------------------

augroup vimrc
  au!

  autocmd BufRead *.txt setfiletype text

  autocmd FileType text setlocal noexpandtab
  autocmd FileType svn setlocal noexpandtab

  " Markdown related
  " NOTE: setting formatoptions+=a causes strange effects in bullets lists
  autocmd FileType markdown
    \ setlocal formatoptions+=ro |
    \ setlocal textwidth=80 |
    \ setlocal complete+=kspell |
    \ call tablemode#Enable()

  " Configuraiotn files related
  autocmd FileType tmux
    \ setlocal formatoptions+=ro |
    \ setlocal textwidth=80

  " Configuraiotn files related
  autocmd FileType vim
    \ setlocal tabstop=2 |
    \ setlocal shiftwidth=2

  " Python related
  autocmd BufNewFile,BufRead *.py 
    \ setlocal formatoptions+=ro |
    \ setlocal foldmethod=indent |
    \ setlocal foldlevel=99

  " Javascript related
  autocmd BufNewFile,BufRead *.js 
    \ setlocal foldmethod=syntax |
    \ setlocal foldlevel=99

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

augroup END


" ----------------------------------------------------------------------
"  Plugins
" ----------------------------------------------------------------------

" Install plugins
source ~/.vim/plug.vim

" Configure plugins
source ~/.vim/plugins.vim


" ----------------------------------------------------------------------
"  Colorscheme and Highlights
" ----------------------------------------------------------------------

set t_Co=256                " force 256 colors
set background=light        " force light background

function! s:sourceHighlights()
  source ~/.vim/highlights.vim
endfunc

call s:sourceHighlights()

augroup ColorSchemeChange
  au!

  " Source highlights after changing colorscheme
  autocmd ColorScheme * call s:sourceHighlights()

augroup END


" ----------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------

source ~/.vim/mappings.vim


" ----------------------------------------------------------------------
"  Post source
" ----------------------------------------------------------------------
if exists("g:loaded_webdevicons")
  " NOTE: after a re-source, fix syntax matching issues (concealing brackets)
  call webdevicons#refresh()
endif

