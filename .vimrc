" .vimrc 
"
" Author: Wojciech 'KosciaK' Pietrzok
" 
" ----------------------------------------------------------------------
"  General settings
" ----------------------------------------------------------------------

if v:progname =~? "evim"
  finish
endif

set nocompatible	" Vim setings

set history=500	    " keep 500 lines of command line history

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" Files to ignore
set wildignore+=*~
set wildignore+=*.pyc,*.pyo
set wildignore+=.git,.git/*
set wildignore+=.bzr,.bzr/*
set wildignore+=.svn,.svn/*
set wildignore+=__pycache__,*/__pycache__/*

set encoding=utf-8  " UTF-8 by default


" ----------------------------------------------------------------------
"  VIM interface
" ----------------------------------------------------------------------

set title           " set window title

set ttyfast         " fast terminal connection

set backspace=indent,eol,start  " backspace removes all

set laststatus=2	" always show status line
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set wildmenu		" wildmenu for comands completion
"set wildmode=longest,list,full

set magic			" magic on for regular expressions

set incsearch		" do incremental searching

if &t_Co > 2 || has("gui_running")
  syntax on			" syntax highliting
  set hlsearch		" highlight the last used search pattern.
endif

set ignorecase		" ignore case when searching
set smartcase		" override ignorecase when Uppercase in search pattern

" NOTE: Hold SHIFT (or CTRL+SHIFT) during selection to disable visual mode!
set mouse=a			" turn mouse on in all modes
" set mouse=vicr			" turn mouse on, except NORMAL mode

set number			" show line numbers
set numberwidth=5   " mininal number of columns for line numbers

set showmatch		" show matching brackets

set wrap
set linebreak
set cpoptions+=n
set showbreak=>>>\ 
set display+=lastline	" display as much of the last line as possible

set scrolloff=3     " let X lines before/after cursor during scroll

" Spellchecking: English and Polish, show 10 best suggestions
set spelllang=en,pl
set spellsuggest=best,10

"set foldcolumn=1    " extra margin to the left

if has('conceal')
  set conceallevel=3      " Devicons suggest 3, others mention 2?
endif

set cursorline            " Highlight current line
set cursorlineopt=number  " Highlight only line number

set fillchars+=vert:\     " Removes pipes | that act as seperators on splits


" ----------------------------------------------------------------------
"  Text, tab, indentation
" ----------------------------------------------------------------------

set tabstop=4       " 4 whitespaces for tabs visual presentation 
set shiftwidth=4    " shift lines by 4 spaces
set shiftround      " round indent to multiple of shiftwidth
set expandtab       " expand tabs into spaces
set smarttab        " set tabs for a shifttabs logic

set listchars=tab:→\ ,eol:¶,extends:→,precedes:<,trail:·,nbsp:°
"set list

set autoindent      " indent when moving to the next line
set smartindent     " smart autoindenting when starting new line


" ----------------------------------------------------------------------
"  Windows, tabs, buffers
" ----------------------------------------------------------------------

set hidden 			" allow closing of windows with unsaved buffers


" ----------------------------------------------------------------------
"  Autocommands
" ----------------------------------------------------------------------

if has("autocmd")

  filetype plugin on	" enable file type detection
  filetype indent on	" load indent files

  " separate autocmd group
  augroup vimrcEx
  " delete previous settings for this group
  au!			

  autocmd BufRead *.txt setfiletype text

  autocmd FileType text setlocal noexpandtab
  autocmd FileType vim setlocal noexpandtab
  autocmd FileType svn setlocal noexpandtab

  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType c set omnifunc=ccomplete#Complete
  autocmd FileType python set omnifunc=pythoncomplete#Complete

  " Markdown related
  autocmd FileType markdown set formatoptions+=ro

  " Python related
  autocmd BufNewFile,BufRead *.py 
    \ set foldmethod=indent |
    \ set foldlevel=99

  " Javascript related
  autocmd BufNewFile,BufRead *.js 
    \ set foldmethod=syntax |
    \ set foldlevel=99

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


" ----------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------

" Don't use Ex mode, use Q for formatting
map Q gq

" More logical yanking (like D, C)
map Y y$

" Reset highlighting
nnoremap <leader><space> :noh<cr>

" Split navigations without pressing Ctrl-W first
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Fold using space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>


" ----------------------------------------------------------------------
"  Commands and functions
" ----------------------------------------------------------------------

" Convenient command to see the difference between the current buffer and the file it was loaded from, thus the changes you made.
"command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
"	 	\ | wincmd p | diffthis


function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun


" ----------------------------------------------------------------------
"  Colorscheme
" ----------------------------------------------------------------------

" set t_Co=256        " force 256 colors
" set bg=light        " force light background

"highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

hi CursorLine ctermbg=254 cterm=NONE
augroup CLClear
    autocmd! ColorScheme * hi CursorLine ctermbg=254 cterm=NONE
augroup END

hi CursorLineNR cterm=bold ctermbg=254
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold ctermbg=254
augroup END


hi TagbarScope cterm=bold ctermfg=5
hi TagbarAccessPublic ctermfg=70

au filetype markdown hi Title term=bold cterm=bold ctermfg=5 gui=bold guifg=Magenta
au filetype markdown hi Identifier ctermfg=2 guifg=Green
au filetype markdown hi mkdListItemCheckbox cterm=bold


" ----------------------------------------------------------------------
"  GUI options
"  # TODO: Move to .gvimrc
" ----------------------------------------------------------------------

set guifont=Deja\ Vu\ Sans\ Mono\ \Nerd\ Font\ 11


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
call plug#begin('~/.vim/bundle')

  " Vim Plug itself, for documentation to work
    Plug 'junegunn/vim-plug'

  " Statusline
    " Plug 'itchyny/lightline.vim'      " configurable statusline

  " File management
    Plug 'scrooloose/nerdtree'
    " Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " Alternate syntax highlighting plugins:
    " Plug 'vwxyutarooo/nerdtree-devicons-syntax'
    " Plug 'her/synicons.vim'
    " Plug 'lambdalisue/glyph-palette.vim' " NOTE: Needs further configuration!

  " Tags viewer
    Plug 'majutsushi/tagbar'        " Tags tree explorer

  " Buffers
    Plug 'jlanzarotta/bufexplorer'  " TODO: Check and configure!
    " Plug 'fholgado/minibufexpl.vim' " tab-like buffers explorer

  " Fuzzy search and file opening
    Plug 'ctrlpvim/ctrlp.vim'

  " Editing
    Plug 'tpope/vim-surround'       " Quoting / parenthesizing made simple
    Plug 'tpope/vim-repeat'         " Repeat supported plugin maps (like vim-surround)
    Plug 'tpope/vim-commentary'     " Commenting stuff out
    Plug 'godlygeek/tabular'        " Tabularize text
    Plug 'dkarter/bullets.vim'      " Bullet lists automation

  " Tab and completion
    Plug 'ervandew/supertab'

  " Language packs - syntax, indentation, highlighting
    let g:polyglot_disabled = ['markdown']  " NOTE: MUST be declared BEFORE loading plugin!
    Plug 'sheerun/vim-polyglot'
    Plug 'plasticboy/vim-markdown'

  " Python
    Plug 'tmhedberg/simpylfold'           " Python folding rules
    Plug 'jeetsukumaran/vim-pythonsense'  " Python text objects and motions

  " Color previews
    Plug 'ap/vim-css-color'

  " Git integration
    Plug 'tpope/vim-fugitive'

  " TODO: Check these plugins out:
    " Plug 'vimwiki/vimwiki'

  " Show icons in NERDTree, CtrlP, etc
    Plug 'ryanoasis/vim-devicons'   " NOTE: Must be loaded as the last one

" End of plugins list
call plug#end()

" ----------------------------------------------------------------------
"  NERDTree settings
" ----------------------------------------------------------------------
nnoremap <leader>n :NERDTreeFocus<CR>   " Open NERDTree
nnoremap <leader>N :NERDTreeFind<CR>    " Open NERDTree and show current file

let g:NERDTreeQuitOnOpen = 1        " Quit after opening file
let g:NERDTreeShowBookmarks = 0     " Don't show bookmarks (toggle with 'B')
let g:NERDTreeShowHidden = 1        " Don't show bookmarks (toggle with 'I')

" Don't show selected files (toggle with 'f')
let g:NERDTreeIgnore = [
      \ '\.*\~$',
      \ '\.pyo$', '\.pyc$',
      \ '__pycache__',
      \ '^node_modules$',
      \]
let g:NERDTreeRespectWildIgnore = 1 " Don't show files in wildignore

let g:NERDTreeMapOpenSplit = 's'    " Remap split to 's'
let g:NERDTreeMapOpenVSplit = 'v'   " Remap vertical split to 'v'


" ----------------------------------------------------------------------
"  NERDTree Git Plugin settings
" ----------------------------------------------------------------------
let g:NERDTreeGitStatusCwdOnly = 1
let g:NERDTreeGitStatusUseNerdFonts = 0
let g:NERDTreeGitStatusShowClean = 0
let g:NERDTreeGitStatusAlignIfConceal = 0


" ----------------------------------------------------------------------
"  NERDTree Syntax Highlight settings
" ----------------------------------------------------------------------
" let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
" let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1

" Disable highlighting by: extension / exact match / pattern
let g:NERDTreeDisableFileExtensionHighlight = 1
" let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1

let g:NERDTreeLimitedSyntax = 1

" Disable all default matching
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1

let g:NERDTreeSyntaxEnabledExactMatches = [
      \ 'dropbox',
      \ 'node_modules',
      \]

" Highlight full name (not only icons) of files
" let g:NERDTreeFileExtensionHighlightFullName = 1
" let g:NERDTreeExactMatchHighlightFullName = 1
" let g:NERDTreePatternMatchHighlightFullName = 1

" Highlight full name (not only icons) of folders
let g:NERDTreeHighlightFolders = 1          " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1  " highlights the folder name


" ----------------------------------------------------------------------
"  DevIcons settings
" ----------------------------------------------------------------------
let g:DevIconsEnableFoldersOpenClose = 1    " Change icon for open dirs

" let g:DevIconsEnableFolderExtensionPatternMatching = 1

let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0

" No padding BEFORE icons in NERDTree
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsNerdTreeAfterGlyphPadding = " "

" Custom file extenstions
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {
      \ 'ttf'   : '',
      \ 'otf'   : '',
      \ 'woff'  : '',
      \ 'gpx'   : '',
      \ 'tcx'   : '',
      \}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {
      \ 'dropbox'   : '',
      \}


" ----------------------------------------------------------------------
"  Tagbar settings
" ----------------------------------------------------------------------
let g:tagbar_autoclose = 1
let g:tagbar_compact = 2
nnoremap <leader>t :TagbarToggle<CR>


" ----------------------------------------------------------------------
"  MiniBufExpl settings
" ----------------------------------------------------------------------
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 0
let g:miniBufExplModSelTarget = 1
let g:miniBufExplUseSingleClick = 1


" ----------------------------------------------------------------------
"  CtrlP settings
" ----------------------------------------------------------------------
let g:ctrlp_switch_buffer = 0 "'et'
" Ignore files from .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']


" ----------------------------------------------------------------------
"  Vim-markdown settings
" ----------------------------------------------------------------------
let g:vim_markdown_strikethrough = 1
" let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_level = 6
let g:vim_markdown_new_list_item_indent = 0
map <F13> <Plug>Markdown_EditUrlUnderCursor   " re-enable default <ge> mapping


" after a re-source, fix syntax matching issues (concealing brackets):
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

