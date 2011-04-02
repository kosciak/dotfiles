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

set history=50		" keep 50 lines of command line history

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

set wildignore+=*.pyc,*~

" ----------------------------------------------------------------------
"  VIM interface
" ----------------------------------------------------------------------

set backspace=indent,eol,start

set laststatus=2	" always show status line
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set wildmenu		" wildmenu for comands completion

set magic			" magic on for regular expressions

set incsearch		" do incremental searching
if &t_Co > 2 || has("gui_running")
  syntax on			" syntax highliting
  set hlsearch		" highlight the last used search pattern.
endif

set ignorecase		" ignore case when searching
set smartcase		" override ignorecase when Uppercase in search pattern

set mouse=a			" turn mouse on

set number			" line numbers
set showmatch		" show matching brackets

set wrap
set linebreak
set cpoptions+=n
set showbreak=>>>\ 
set display+=lastline	" display as much of the last line as possible

set scrolloff=3

" Spellchecking: English and Polish, show 10 best suggestions
set spelllang=en,pl
set spellsuggest=best,10


" ----------------------------------------------------------------------
"  Text, tab, indentation
" ----------------------------------------------------------------------

set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smarttab

set listchars=tab:→\ ,eol:¶,extends:→,precedes:<,trail:·,nbsp:°
"set list

set autoindent
set smartindent


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

nnoremap <leader><space> :noh<cr>


" ----------------------------------------------------------------------
"  Commands
" ----------------------------------------------------------------------

" Convenient command to see the difference between the current buffer and the file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis



" ----------------------------------------------------------------------
"  Colorscheme
" ----------------------------------------------------------------------

"highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/


" ----------------------------------------------------------------------
"  GUI options
" ----------------------------------------------------------------------

set guifont=Monospace\ 9


" ----------------------------------------------------------------------
"  Plugins
" ----------------------------------------------------------------------

" CSApprox
let g:CSApprox_loaded=1

" TagList
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Close_On_Select = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Inc_Winwidth = 0					" Fix for terminal

" bufExplorer
let g:bufExplorerDefaultHelp=0

" MiniBufferExplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 0
let g:miniBufExplModSelTarget = 1 
let g:miniBufExplUseSingleClick = 1
"let g:miniBufExplorerMoreThanOne = 1
"let g:miniBufExplForceSyntaxEnable = 1		" Messes up TagList colouring

" NERDTree
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=0
let NERDTreeShowBookmarks=1

" svndiff
hi DiffAdd      ctermfg=0 ctermbg=2 guibg='green'
hi DiffDelete   ctermfg=0 ctermbg=1 guibg='red'
hi DiffChange   ctermfg=0 ctermbg=3 guibg='yellow' 
let g:svndiff_autoupdate=1 

" ctags
let g:ctags_title=0
let g:ctags_statusline=1
let generate_tags=1

