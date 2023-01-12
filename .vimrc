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

set ttyfast         " fast terminal connection


" ----------------------------------------------------------------------
"  VIM interface
" ----------------------------------------------------------------------

set title           " set window title

set backspace=indent,eol,start  " backspace removes all

set laststatus=2	" always show status line
set ruler			" show the cursor position all the time

set statusline=
set statusline+=%m                  " Modified flag: [+] or [-]
set statusline+=%<                  " Truncate if too long
set statusline+=%h%w%q%r            " Flags: Help, Preview, *List, Readonly
set statusline+=\                   " Space
" set statusline+=%{GetStatusLineGit()}
set statusline+=%{GetStatusLineIcon()}
set statusline+=\                   " Space
set statusline+=%#StatusLinePath#   " Start named highlight group
set statusline+=%{GetStatusLinePath()}
set statusline+=%*                  " Reset highlight group
set statusline+=%t                  " File name
set statusline+=%=                  " left/right alignment separator
" set statusline+=%<%{GetStatusLineTag()}\ 
set statusline+=%y                  " Filetype
set statusline+=\                   " Space
set statusline+=%7.(%l:%c%)         " Line number : Column number
set statusline+=%5p%%               " Percentage through file in lines
set statusline+=\                   " Space

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
  set conceallevel=2
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
    \ set formatoptions+=ro |
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
endfunc


function! GetStatusLinePath()
  let path = substitute(expand('%:h'), '^\.$', '', 'i')
  if strlen(path) == 0
    return ''
  elseif path[0] ==# '/' || path[0:2] ==# '../'
    return expand('%:~:h') .. '/'
  else
    return path .. '/'
  endif
endfunc


function! GetStatusLineIcon()
  return WebDevIconsGetFileTypeSymbol()
endfunc


function! GetStatusLineGit()
  let branch = FugitiveHead()
  if strlen(branch) > 0
    return ' ' .. branch .. '%* '
  else
    return ''
  endif
endfunc


function! GetStatusLineTag()
  " let tag = tagbar#currenttag(' %s', '', 'f')
  let tag = tagbar#currenttag(' %s', '')
  if strlen(tag) > 0
    return tag
  else
    return ''
  endif
endfunc


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

hi StatusLinePath cterm=reverse",italic

hi TagbarScope cterm=bold ctermfg=5
hi TagbarAccessPublic ctermfg=70

autocmd FileType markdown hi Title term=bold cterm=bold ctermfg=5 gui=bold guifg=Magenta
autocmd FileType markdown hi Identifier ctermfg=2 guifg=Green
autocmd FileType markdown hi mkdListItemCheckbox cterm=bold


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

  " Buffers / Tabs
    Plug 'jlanzarotta/bufexplorer'  " TODO: Check and configure!
    " Plug 'fholgado/minibufexpl.vim' " tab-like buffers explorer
    " Plug 'ap/vim-buftabline'

  " Fuzzy search and file opening
    Plug 'ctrlpvim/ctrlp.vim'

  " File management
    Plug 'scrooloose/nerdtree'
    " Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    " Plug 'obaland/vfiler.vim'
    " Plug 'obaland/vfiler-column-devicons'

  " Tags viewer
    Plug 'majutsushi/tagbar'        " Tags tree explorer

  " Editing
    Plug 'tpope/vim-surround'         " Quoting / parenthesizing made simple
    Plug 'tpope/vim-repeat'           " Repeat supported plugin maps (like vim-surround)

    Plug 'tpope/vim-commentary'       " Commenting stuff out

    Plug 'godlygeek/tabular'          " Tabularize text
    Plug 'dhruvasagar/vim-table-mode' " Table creator and formatter

    Plug 'lervag/vim-rainbow-lists'   " Highlight list indentation levels
    Plug 'dkarter/bullets.vim'        " Bullet lists automation
    " Plug 'lervag/lists.vim'

    Plug 'AndrewRadev/sideways.vim'   " Move items to the righ or left
    Plug 'machakann/vim-swap'         " Arguments swapping

  " Tab and completion
    Plug 'ervandew/supertab'

  " Language packs - syntax, indentation, highlighting
    let g:polyglot_disabled = ['markdown']  " NOTE: MUST be declared BEFORE loading plugin!
    Plug 'sheerun/vim-polyglot'

    Plug 'plasticboy/vim-markdown'
    " Plug 'vim-pandoc/vim-pandoc'

    Plug 'tmhedberg/simpylfold'           " Python folding rules
    Plug 'jeetsukumaran/vim-pythonsense'  " Python text objects and motions

  " Color previews
    Plug 'ap/vim-css-color'

  " Git integration
    Plug 'tpope/vim-fugitive'

  " Wiki, notes taking, journaling
    " Plug 'vimwiki/vimwiki'
    Plug 'lervag/wiki.vim'                " TODO: configure!

    Plug 'mtth/scratch.vim'

  " Icons
    " NOTE: Must be loaded as the last one
    Plug 'ryanoasis/vim-devicons'

" End of plugins list
call plug#end()


" ----------------------------------------------------------------------
"  NERDTree - 'scrooloose/nerdtree'
" ----------------------------------------------------------------------

let g:NERDTreeQuitOnOpen = 1        " Quit after opening file
let g:NERDTreeMinimalUI = 1         " Don't show bookmarks and help prompt
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
"  NERDTree Git Plugin - 'Xuyuanp/nerdtree-git-plugin'
" ----------------------------------------------------------------------

let g:NERDTreeGitStatusCwdOnly = 1
let g:NERDTreeGitStatusUseNerdFonts = 0
let g:NERDTreeGitStatusShowClean = 0
let g:NERDTreeGitStatusAlignIfConceal = 0


" ----------------------------------------------------------------------
"  NERDTree Syntax Highlight - 'tiagofumo/vim-nerdtree-syntax-highlight'
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
"  DevIcons - 'ryanoasis/vim-devicons'
" ----------------------------------------------------------------------

let g:DevIconsEnableFoldersOpenClose = 1    " Change icon for open dirs

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1

let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0

" No padding BEFORE icons in NERDTree
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsNerdTreeAfterGlyphPadding = " "

" Adding custom decoration rules
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
"  Tagbar - 'majutsushi/tagbar'
" ----------------------------------------------------------------------

let g:tagbar_autoclose = 1
let g:tagbar_compact = 2


" ----------------------------------------------------------------------
"  Buffer Explorer - 'jlanzarotta/bufexplorer'
" ----------------------------------------------------------------------

let g:bufExplorerDefaultHelp = 0
let g:bufExplorerSplitOutPathName = 0
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerDisableDefaultKeyMapping = 1


" ----------------------------------------------------------------------
"  MiniBufExpl - 'fholgado/minibufexpl.vim'
" ----------------------------------------------------------------------

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 0
let g:miniBufExplModSelTarget = 1
let g:miniBufExplUseSingleClick = 1


" ----------------------------------------------------------------------
"  CtrlP - 'ctrlpvim/ctrlp.vim'
" ----------------------------------------------------------------------

let g:ctrlp_switch_buffer = 0 "'et'
" Ignore files from .gitignore
let g:ctrlp_user_command = [
      \ '.git',
      \ 'cd %s && git ls-files . --cached --exclude-standard --others',
      \]


" ----------------------------------------------------------------------
"  Vim-markdown - 'plasticboy/vim-markdown'
" ----------------------------------------------------------------------

let g:vim_markdown_strikethrough = 1
" let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_level = 6
let g:vim_markdown_new_list_item_indent = 0
map <F13> <Plug>Markdown_EditUrlUnderCursor   " re-enable default <ge> mapping


" ----------------------------------------------------------------------
"  Table Mode - 'dhruvasagar/vim-table-mode'
" ----------------------------------------------------------------------

autocmd FileType markdown let g:table_mode_verbose = 0
autocmd FileType markdown :TableModeEnable


" ----------------------------------------------------------------------
"  Bullets - 'dkarter/bullets.vim'
" ----------------------------------------------------------------------

let g:bullets_checkbox_partials_toggle = 0


" ----------------------------------------------------------------------
"  Scratch - 'mtth/scratch.vim'
" ----------------------------------------------------------------------

let g:scratch_insert_autohide = 0
let g:scratch_filetype = 'markdown'

" ----------------------------------------------------------------------
"  Wiki.vim - 'lervag/wiki.vim'
" ----------------------------------------------------------------------

let g:wiki_root = '~/projekty/wiki'
let wiki_global_load = 0
let g:wiki_filetypes = ['md', 'wiki']
autocmd FileType markdown let g:wiki_link_extension = '.md'
autocmd FileType markdown let g:wiki_link_target_type = 'md'
autocmd FileType wiki let g:wiki_link_extension = '.wiki'
autocmd FileType wiki let g:wiki_link_target_type = 'wiki'


" ----------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------

" Don't use Ex mode, use Q for formatting
map Q gq

" More logical yanking (like D, C)
map Y y$

" Reset highlighting
nnoremap <leader><space> :noh<cr>

" Toggle between paste and nopaste, with visual feedback
nnoremap <leader>p :set invpaste paste?<CR>
set pastetoggle=<leader>p

" Split navigations without pressing Ctrl-W first
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Close window
nnoremap <leader>q :close<CR>

" Increment using Ctrl-i (not to interfere with screen leader key)
nnoremap <C-i> <C-a>

" Fold using space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>   " Open NERDTree
nnoremap <leader>N :NERDTreeFind<CR>    " Open NERDTree and show current file
nnoremap <leader>f :NERDTreeFocus<CR>   " Open NERDTree
nnoremap <leader>c :NERDTreeFind<CR>    " Open NERDTree and show current file

" Tagbar
nnoremap <leader>a :TagbarToggle<CR>

" Buffer Explorer
nnoremap <leader>b :BufExplorer<CR>
" nnoremap <leader>b :ToggleBufExplorer<CR>

" Sideways and Swap
" NOTE: Sideways is more versatile, but Swap's interactive mode is so good! 
let g:swap_no_default_key_mappings = 1
nnoremap gsh :SidewaysLeft<cr>
nnoremap gsl :SidewaysRight<cr>
nnoremap gss <Plug>(swap-interactive)

" Scratch
let g:scratch_no_mappings = 1
nmap <leader>si <plug>(scratch-insert-reuse)
nmap <leader>sc <plug>(scratch-insert-clear)
xmap <leader>si <plug>(scratch-selection-reuse)
xmap <leader>sc <plug>(scratch-selection-clear)
nnoremap <leader>ss :Scratch<CR>
nnoremap <leader>sp :ScratchPreview<CR>

" Bullets
autocmd FileType markdown nnoremap <C-x> :ToggleCheckbox<CR>

" Rainbow list
autocmd FileType markdown nnoremap <leader>r :RBListToggle<CR>


" ----------------------------------------------------------------------
" after a re-source, fix syntax matching issues (concealing brackets):
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

