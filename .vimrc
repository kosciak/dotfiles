" .vimrc
" .vim/term.vim
" .vim/plugins.vim
" .vim/highlights.vim
" .vim/mappings.vim
" .vim/autoload/statusline.vim
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

" Terminal and escape sequences settings
source ~/.vim/term.vim


" ----------------------------------------------------------------------
"  Interface
" ----------------------------------------------------------------------

set title           " set window title

set statusline=
set statusline+=%m                  " Modified flag: [+] or [-]
set statusline+=%<                  " Truncate if too long
set statusline+=%h%w%q%r            " Flags: Help, Preview, *List, Readonly
set statusline+=%{%statusline#Icon('\ ','\ ')%}
set statusline+=%#StatusLineNormal#   " Start named highlight group
set statusline+=%{statusline#Path()}
set statusline+=%*                  " Reset highlight group
" set statusline+=%t                  " File name
set statusline+=%{statusline#Filename()}
set statusline+=\                   " Space
set statusline+=%{statusline#Paste()}
" set statusline+=%{statusline#Spell()}
set statusline+=%=                  " left/right alignment separator
" set statusline+=%<%{statusline#Tag('')}\ 
set statusline+=%#StatusLineNormal#   " Start named highlight group
set statusline+=%y                  " Filetype
set statusline+=%*                  " Reset highlight group
set statusline+=%{statusline#Git('\ \ \ ')}
set statusline+=\                   " Space
set statusline+=%7.(%l:%c%)         " Line number : Column number
set statusline+=%5p%%               " Percentage through file in lines
set statusline+=\                   " Space

set showcmd         " display incomplete commands
"set wildmode=longest,list,full

set magic           " magic on for regular expressions

if &t_Co > 2 || has("gui_running")
  set hlsearch      " highlight the last used search pattern.
endif

set ignorecase      " ignore case when searching
set smartcase       " override ignorecase when Uppercase in search pattern

set number          " show line numbers
set numberwidth=5   " mininal number of columns for line numbers

set showmatch       " show matching brackets

set wrap
set linebreak
set cpoptions+=n
set showbreak=>>>\ 

set scrolloff=3     " let X lines before/after cursor during scroll

"set foldcolumn=1    " extra margin to the left

if has('conceal')
  set conceallevel=2
endif

" Highlight current line
set cursorline
" with only line number, EXCEPT selected FileTypes:
set cursorlineopt=number
autocmd FileType tagbar,nerdtree,ctrlp
 \ set cursorlineopt=both

set fillchars+=vert:\     " Removes pipes | that act as seperators on splits

set completeopt=menu  " on completion show only menu, no preview or popup


" ----------------------------------------------------------------------
"  Editing
" ----------------------------------------------------------------------

set tabstop=4       " 4 whitespaces for tabs visual presentation 
set shiftwidth=4    " shift lines by 4 spaces
set shiftround      " round indent to multiple of shiftwidth
set expandtab       " expand tabs into spaces

" NOTE: Needs 'set list' to work and show listchars!
set listchars=tab:→\ ,eol:¶,extends:→,precedes:<,trail:·,nbsp:°

set autoindent      " indent when moving to the next line
set smartindent     " smart autoindenting when starting new line

" Spellchecking: English and Polish, show 10 best suggestions
set spelllang=en,pl
set spellsuggest=best,10


" ----------------------------------------------------------------------
"  Windows, tabs, buffers
" ----------------------------------------------------------------------

set hidden          " allow closing of windows with unsaved buffers


" ----------------------------------------------------------------------
"  Autocommands
" ----------------------------------------------------------------------

if has("autocmd")

  " separate autocmd group
  augroup vimrcEx
  " delete previous settings for this group
  au!

  autocmd BufRead *.txt setfiletype text

  autocmd FileType text setlocal noexpandtab
  autocmd FileType vim setlocal noexpandtab
  autocmd FileType svn setlocal noexpandtab

  " Markdown related
  autocmd FileType markdown
    \ setlocal formatoptions+=ro |
    \ setlocal textwidth=80 |
    \ call tablemode#Enable()

  " Configuraiotn files related
  autocmd FileType tmux
    \ setlocal formatoptions+=ro |
    \ setlocal textwidth=80

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

endif " has("autocmd")


" ----------------------------------------------------------------------
"  Plugins
" ----------------------------------------------------------------------

" Auto install Vim-plug manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Declare plugins install directory
call plug#begin()

  " Vim Plug itself, for documentation to work
    Plug 'junegunn/vim-plug'

  " Config
    Plug 'tpope/vim-sensible'         " Sensible default settings

  " Filesystem
    Plug 'duggiefresh/vim-easydir'    " Create directories on :write

  " Editing
    Plug 'tpope/vim-surround'         " Quoting / parenthesizing made simple
    Plug 'tpope/vim-repeat'           " Repeat supported plugin maps (like vim-surround)

    Plug 'tpope/vim-commentary'       " Commenting stuff out

    Plug 'godlygeek/tabular'          " Tabularize text NOTE: Load *before* vim-markdown!
    Plug 'dhruvasagar/vim-table-mode' " Table creator and formatter

    Plug 'lervag/vim-rainbow-lists'   " Highlight list indentation levels
    Plug 'dkarter/bullets.vim'        " Bullet lists automation
    " Plug 'lervag/lists.vim'

    Plug 'AndrewRadev/sideways.vim'   " Move items to the righ or left
    Plug 'machakann/vim-swap'         " Arguments swapping

    " Plug 'rhysd/clever-f.vim'         " Better f, F, t, T repeating

  " Language packs - syntax, indentation, highlighting
    let g:polyglot_disabled = ['markdown']  " NOTE: MUST be declared BEFORE loading plugin!
    Plug 'sheerun/vim-polyglot'           " Collection of language packs
      " Provided by polyglot (install separately if you need help file):
      Plug 'plasticboy/vim-markdown'      " Updated version
      " Plug 'pangloss/vim-javascript'
      " Plug 'vim-python/python-syntax'
      " Plug 'Vimjas/vim-python-pep8-indent'

    Plug 'chikamichi/mediawiki.vim'

    Plug 'tmhedberg/simpylfold'           " Python folding rules
    Plug 'jeetsukumaran/vim-pythonsense'  " Python text objects and motions

    " Plug 'SidOfc/mkdx'                  " Feature rich if not too complicated
    " Plug 'vim-pandoc/vim-pandoc'
    " Plug 'vim-pandoc/vim-pandoc-syntax'

  " Buffers / Windows / Tabs
    Plug 'jlanzarotta/bufexplorer'    " Buffer explorer / switcher

    Plug 'tyru/capture.vim'           " Show Ex command in a buffer

    Plug 'sedm0784/vim-resize-mode'   " Window Resize mode

  " Registers
    Plug 'junegunn/vim-peekaboo'      " Show register's contents in sidebar

  " Search
    Plug 'ctrlpvim/ctrlp.vim'         " Full path fuzzy finder
    Plug 'dyng/ctrlsf.vim'            " TODO: Configure!
    Plug 'jremmen/vim-ripgrep'        " TODO: Check if needed

  " Files
    Plug 'scrooloose/nerdtree'
    " Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    " Plug 'obaland/vfiler.vim'
    " Plug 'obaland/vfiler-column-devicons'

  " Tags
    Plug 'majutsushi/tagbar'          " Tags tree explorer

  " Completion
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
    Plug 'ervandew/supertab'          " Improved Tab completion

  " Color previews
    Plug 'ap/vim-css-color'

  " Version control
    Plug 'tpope/vim-fugitive'         " Git integration
    Plug 'junegunn/gv.vim'            " Git commit browser

  " Wiki, notes taking, journaling
    Plug 'lervag/wiki.vim'            " Wiki engine

    Plug 'mtth/scratch.vim'           " Temporary scratch buffer

  " Icons
    " NOTE: Must be loaded as the last one
    Plug 'ryanoasis/vim-devicons'     " Enable NerdFonts support

" End of plugins list
call plug#end()


" ----------------------------------------------------------------------
"  Plugins settings
" ----------------------------------------------------------------------

source ~/.vim/plugins.vim


" ----------------------------------------------------------------------
"  Colorscheme
" ----------------------------------------------------------------------

set t_Co=256                " force 256 colors
set background=light        " force light background

source ~/.vim/highlights.vim


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

