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
  set conceallevel=3
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
"  Commands
" ----------------------------------------------------------------------

" Convenient command to see the difference between the current buffer and the file it was loaded from, thus the changes you made.
"command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
"	 	\ | wincmd p | diffthis


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


hi TagbarScope cterm=bold
hi TagbarAccessPublic ctermfg=70


" ----------------------------------------------------------------------
"  GUI options
"  # TODO: Move to .gvimrc
" ----------------------------------------------------------------------

set guifont=Monospace\ 9


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

 " Lightline - configurable statusline
 " Plug 'itchyny/lightline.vim'

 " Tree explorer
 Plug 'scrooloose/nerdtree'
 " Plug 'Xuyuanp/nerdtree-git-plugin'
 Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
 " Alternate syntax highlighting plugins:
 " Plug 'vwxyutarooo/nerdtree-devicons-syntax'
 " Plug 'her/synicons.vim'
 " Plug 'lambdalisue/glyph-palette.vim' " NOTE: Needs further configuration!

 " Tags explorer
 Plug 'majutsushi/tagbar'

 " MiniBufExpl
 " Plug 'fholgado/minibufexpl.vim'

 " Buffer explorer
 Plug 'jlanzarotta/bufexplorer'

 " CtrlP - fuzzy search and file opening
 Plug 'ctrlpvim/ctrlp.vim'

 " Quoting / parenthesizing made simple
 Plug 'tpope/vim-surround'

 " Repeat supported plugin maps (like vim-surround)
 Plug 'tpope/vim-repeat'

 " Commenting stuff out
 Plug 'tpope/vim-commentary'

 " Tab for completion
 Plug 'ervandew/supertab'

 " Language packs - indentation, highlighting
 Plug 'sheerun/vim-polyglot'

 " Python folding rules
 Plug 'tmhedberg/simpylfold'

 " Python text objects and motions
 Plug 'jeetsukumaran/vim-pythonsense'

 " Color previews for #RRGGBB notation
 Plug 'ap/vim-css-color'

 " Git wrapper
 Plug 'tpope/vim-fugitive'

 " TODO: Check them out
 " Plug 'vimwiki/vimwiki'

 " Show icons in NERDTree, *line, CtrlP, etc
 " NOTE: Must be loaded as the last one
 Plug 'ryanoasis/vim-devicons'

" End of plugins list
call plug#end()


" ----------------------------------------------------------------------
"  NERDTree settings
" ----------------------------------------------------------------------
nnoremap <leader>n :NERDTreeFocus<CR>   " Open NERDTree
let g:NERDTreeQuitOnOpen = 1        " Quit after opening file
let g:NERDTreeShowBookmarks = 0     " Don't show bookmarks (toggle with 'B')
let g:NERDTreeShowHidden = 0        " Don't show bookmarks (toggle with 'I')

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
"  NERDTree Syntax Highliting settings
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
let g:tagbar_autoclose=1
nnoremap <leader>t :TagbarToggle<CR>


" ----------------------------------------------------------------------
"  MiniBufExpl
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


" after a re-source, fix syntax matching issues (concealing brackets):
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

