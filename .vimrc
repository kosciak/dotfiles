" .vimrc
" .gvimrc
" .vim/term.vim
" .vim/plugins.vim
" .vim/plugins-obsolete.vim
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

set nomodeline      " Disable modeline magic settings

set updatetime=100  " Better performance of vim-signify, YCM, and others

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

set showcmd         " display incomplete commands

set wildmode=longest,full
if v:version > 900
  " set wildoptions=fuzzy
  set wildoptions=pum
endif

" On completion show only menu, no preview or popup
" NOTE: YCM changes 'menu' to 'menuone' and removes 'longest'
"       https://github.com/ycm-core/YouCompleteMe/issues/562
"       Well... completeopt has global scope so no luck with that
set completeopt=menuone,longest
let s:override_completeopt = &completeopt
let s:restore_completeopt = &completeopt

function! s:overrideCompleteopt() abort
  if exists("g:loaded_youcompleteme") && has_key(g:ycm_filetype_blacklist, &ft)
    let s:restore_completeopt = &completeopt
    let &completeopt = s:override_completeopt
  endif
endfunc

function! s:restoreCompleteopt() abort
  if exists("g:loaded_youcompleteme") && has_key(g:ycm_filetype_blacklist, &ft)
    let &completeopt = s:restore_completeopt
  endif
endfunc

augroup RestoreCompleteopt
  au!
  autocmd InsertEnter * call s:overrideCompleteopt()
  autocmd InsertLeave * call s:restoreCompleteopt()
augroup END

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

augroup SpecialCursorlineopt
  au!

  autocmd FileType tagbar,nerdtree,ctrlp
  \ set cursorlineopt=both

augroup END

set fillchars+=vert:\     " Removes pipes | that act as seperators on splits


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
    Plug 'tpope/vim-repeat'           " Repeat supported plugin maps (like vim-surround)
    Plug 'tpope/vim-surround'         " Quoting / parenthesizing made simple
    Plug 'tpope/vim-commentary'       " Commenting stuff out
    Plug 'tpope/vim-speeddating'      " Increment / decrement dates

    Plug 'godlygeek/tabular'          " Tabularize text NOTE: Load *before* vim-markdown!
    Plug 'dhruvasagar/vim-table-mode' " Table creator and formatter

    Plug 'dkarter/bullets.vim'        " Bullet lists automation
    " Plug 'lervag/lists.vim'

    Plug 'AndrewRadev/sideways.vim'   " Move items to the righ or left
    Plug 'machakann/vim-swap'         " Arguments swapping

    Plug 'alvan/vim-closetag'         " Auto close HTML tags

    " Plug 'rhysd/clever-f.vim'         " Better f, F, t, T repeating

  " Language packs - syntax, indentation, highlighting
    let g:polyglot_disabled = ['markdown']  " NOTE: MUST be declared BEFORE loading plugin!
    " let g:polyglot_disabled = ['autoindent']  " Disable indentation heuristics
    Plug 'sheerun/vim-polyglot'           " Collection of language packs
      " Provided by polyglot (install separately if you need help file):
      Plug 'plasticboy/vim-markdown'      " Updated version
      " Plug 'pangloss/vim-javascript'
      " Plug 'vim-python/python-syntax'
      " Plug 'Vimjas/vim-python-pep8-indent'

    Plug 'chikamichi/mediawiki.vim'

    Plug 'raimon49/requirements.txt.vim'  " Syntax for requirements.txt files

    Plug 'tmhedberg/simpylfold'           " Python folding rules
    Plug 'jeetsukumaran/vim-pythonsense'  " Python text objects and motions

    Plug 'michaeljsmith/vim-indent-object'  " Indentation oriented text objects
    Plug 'wellle/targets.vim'             " Improved text objects

    " Plug 'SidOfc/mkdx'                  " Feature rich if not too complicated
    " Plug 'vim-pandoc/vim-pandoc'
    " Plug 'vim-pandoc/vim-pandoc-syntax'

    " Plug 'groenewege/vim-less'          " TODO: Check if needed

  " Buffers / Windows / Tabs
    Plug 'jlanzarotta/bufexplorer'    " Buffer explorer / switcher

    Plug 'ton/vim-bufsurf'            " Jump to previous / next file

    Plug 'tyru/capture.vim'           " Show Ex command in a buffer

    " Plug 'sedm0784/vim-resize-mode'   " Window Resize mode

  " Registers
    Plug 'junegunn/vim-peekaboo'      " Show register's contents in sidebar

  " Search
    Plug 'ctrlpvim/ctrlp.vim'         " Full path fuzzy finder

    " Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

    " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " Plug 'junegunn/fzf.vim'

    Plug 'dyng/ctrlsf.vim'            " TODO: Configure!

    " Plug 'lokikl/vim-ctrlp-ag'        " TODO: Check and configure
    " Plug 'jremmen/vim-ripgrep'        " TODO: Check if needed

  " Files
    Plug 'scrooloose/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " Plug 'Xuyuanp/nerdtree-git-plugin'

    " Plug 'lambdalisue/fern.vim'
    " Plug 'lambdalisue/nerdfont.vim'
    " Plug 'lambdalisue/fern-renderer-nerdfont.vim'
    " Plug 'lambdalisue/glyph-palette.vim'
    " Plug 'lambdalisue/fern-git-status.vim'
    " Plug 'lambdalisue/fern-hijack.vim'
    " Plug 'yuki-yano/fern-preview.vim'
    " Plug 'KosukeMizuno/ctrlp-fern-action.vim'
    " let g:fern#renderer = "nerdfont"

    " Plug 'obaland/vfiler.vim'
    " Plug 'obaland/vfiler-column-devicons'

  " Tags
    Plug 'majutsushi/tagbar'          " Tags tree explorer

  " Completion
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --ts-completer' }

    Plug 'ervandew/supertab'          " Improved Tab completion

  " Color previews
    Plug 'ap/vim-css-color'

  " Version control
    Plug 'tpope/vim-fugitive'         " Git integration
    Plug 'tpope/vim-rhubarb'          " :GBrowse GitHub support
    Plug 'junegunn/gv.vim'            " Git commit browser
    Plug 'mhinz/vim-signify'          " Show changed/added/deleted lines

  " Wiki, notes taking, journaling
    Plug 'lervag/wiki.vim'            " Wiki engine

    Plug 'mtth/scratch.vim'           " Temporary scratch buffer

  " Distraction free mode
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'

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

