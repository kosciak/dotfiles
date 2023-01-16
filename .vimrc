" .vimrc
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" .vimrc
" .vim/autoload/statusline.vim
" .vim/autoload/syntax.vim
" .vim/ftplugin/mediawiki.vim
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
set wildignore+=__pycache__,*/__pycache__/*

set encoding=utf-8  " UTF-8 by default

set ttyfast         " fast terminal connection


" ----------------------------------------------------------------------
"  VIM interface
" ----------------------------------------------------------------------

set title           " set window title

set statusline=
set statusline+=%m                  " Modified flag: [+] or [-]
set statusline+=%<                  " Truncate if too long
set statusline+=%h%w%q%r            " Flags: Help, Preview, *List, Readonly
set statusline+=\                   " Space
" set statusline+=%{statusline#Git()}
set statusline+=%{statusline#Icon()}
set statusline+=\                   " Space
set statusline+=%#StatusLineNormal#   " Start named highlight group
set statusline+=%{statusline#Path()}
set statusline+=%*                  " Reset highlight group
set statusline+=%t                  " File name
set statusline+=%=                  " left/right alignment separator
" set statusline+=%<%{statusline#Tag()}\ 
set statusline+=%#StatusLineNormal#   " Start named highlight group
set statusline+=%y                  " Filetype
set statusline+=%*                  " Reset highlight group
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

" NOTE: Hold SHIFT (or CTRL+SHIFT) during selection to disable visual mode!
set mouse=a         " turn mouse on in all modes
set mouse=vicr      " turn mouse on in all modes

set number          " show line numbers
set numberwidth=5   " mininal number of columns for line numbers

set showmatch       " show matching brackets

set wrap
set linebreak
set cpoptions+=n
set showbreak=>>>\ 

set scrolloff=3     " let X lines before/after cursor during scroll

" Spellchecking: English and Polish, show 10 best suggestions
set spelllang=en,pl
set spellsuggest=best,10

"set foldcolumn=1    " extra margin to the left

if has('conceal')
  set conceallevel=2
endif

set cursorline      " Highlight current line
" with only line number, EXCEPT selected FileTypes:
set cursorlineopt=number
autocmd FileType tagbar,nerdtree,ctrlp
 \ set cursorlineopt=both

set fillchars+=vert:\     " Removes pipes | that act as seperators on splits

set completeopt=menu  " on completion show only menu, no preview or popup


" ----------------------------------------------------------------------
"  Text, tab, indentation
" ----------------------------------------------------------------------

set tabstop=4       " 4 whitespaces for tabs visual presentation 
set shiftwidth=4    " shift lines by 4 spaces
set shiftround      " round indent to multiple of shiftwidth
set expandtab       " expand tabs into spaces

" NOTE: Needs 'set list' to work and show listchars!
set listchars=tab:→\ ,eol:¶,extends:→,precedes:<,trail:·,nbsp:°

set autoindent      " indent when moving to the next line
set smartindent     " smart autoindenting when starting new line


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

else

  set autoindent      " always set autoindenting on

endif " has("autocmd")


" ----------------------------------------------------------------------
"  Colorscheme
"  NOTE: highlight by default is global
" ----------------------------------------------------------------------

set t_Co=256                " force 256 colors
set background=light        " force light background

"highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

" hi SpecialKey term=bold ctermfg=7 guifg=Blue
" hi NonText term=bold ctermfg=7 gui=bold guifg=Blue

hi CursorLine ctermbg=254 cterm=NONE
augroup CLClear
    autocmd! ColorScheme * hi CursorLine ctermbg=253 cterm=NONE
augroup END

hi CursorLineNR term=bold cterm=bold ctermbg=254
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold ctermbg=253
augroup END

" hi StatusLineNormal cterm=reverse,italic
hi StatusLineNormal cterm=reverse

hi bufExplorerMapping term=bold ctermfg=6 guifg=Cyan

hi TagbarScope cterm=bold ctermfg=5
hi TagbarAccessPublic ctermfg=70

" Markup - bold headers
hi htmlTitle term=bold cterm=bold ctermfg=5 gui=bold guifg=Magenta
hi htmlH1 term=bold cterm=bold ctermfg=5 gui=bold guifg=Magenta

" Markup - list markers
hi mkdListItem term=bold cterm=bold ctermfg=2 gui=bold guifg=Green
hi mkdRule term=bold cterm=bold ctermfg=2 gui=bold guifg=Green
" with bold checkboxes: [ ] [x]
hi mkdListItemCheckbox term=bold cterm=bold ctermbg=254 gui=bold
hi mkdHeading term=bold cterm=bold ctermbg=254 gui=bold

" Diff
hi diffAdded ctermfg=2 guifg=Green
hi diffRemoved ctermfg=1 guifg=Red
hi diffFile term=bold cterm=bold ctermfg=4 guifg=Blue
hi diffIndexLine cterm=bold ctermfg=5 guifg=Magenta
hi diffLine ctermfg=6 guifg=Cyan

" call matchadd('Conceal', '\[\ \]', 0, 11, {'conceal': ''})
" call matchadd('Conceal', '\[X\]', 0, 12, {'conceal': ''})
" call matchadd('Conceal', '\[x\]', 0, 13, {'conceal': ''})
" hi Conceal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE


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

  " Buffers / Tabs
    Plug 'jlanzarotta/bufexplorer'    " TODO: Check and configure!

    Plug 'tyru/capture.vim'           " Show Ex command in a buffer

  " Registers
    Plug 'junegunn/vim-peekaboo'      " Show register's contents in sidebar

  " Search
    Plug 'ctrlpvim/ctrlp.vim'         " Full path fuzzy finder
    Plug 'dyng/ctrlsf.vim'            " TODO: Configure!
    Plug 'jremmen/vim-ripgrep'

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
    Plug 'ervandew/supertab'

  " Color previews
    Plug 'ap/vim-css-color'

  " Version control
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'

  " Wiki, notes taking, journaling
    Plug 'lervag/wiki.vim'            " TODO: configure!

    Plug 'mtth/scratch.vim'           " Temporary scratch buffer

  " Icons
    " NOTE: Must be loaded as the last one
    Plug 'ryanoasis/vim-devicons'

" End of plugins list
call plug#end()


" ----------------------------------------------------------------------
"  Plugins settings
" ----------------------------------------------------------------------

" ----------------------------------------------------------------------
"   scrooloose/nerdtree
" ----------------------------------------------------------------------
let g:NERDTreeQuitOnOpen = 1        " Quit after opening file
let g:NERDTreeMinimalUI = 1         " Don't show bookmarks and help prompt
let g:NERDTreeShowBookmarks = 0     " Don't show bookmarks (toggle with 'B')
let g:NERDTreeShowHidden = 1        " Don't show bookmarks (toggle with 'I')

let g:NERDTreeWinSize = 40

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
"   Xuyuanp/nerdtree-git-plugin
" ----------------------------------------------------------------------
let g:NERDTreeGitStatusCwdOnly = 1
let g:NERDTreeGitStatusUseNerdFonts = 0
let g:NERDTreeGitStatusShowClean = 0
let g:NERDTreeGitStatusAlignIfConceal = 0

" ----------------------------------------------------------------------
"   tiagofumo/vim-nerdtree-syntax-highlight
" ----------------------------------------------------------------------
let g:NERDTreeLimitedSyntax = 1

" let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
" let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1

" Disable highlighting by: extension / exact match / pattern
let g:NERDTreeDisableFileExtensionHighlight = 1
" let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1

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
"   ryanoasis/vim-devicons
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
"   majutsushi/tagbar
" ----------------------------------------------------------------------
let g:tagbar_autoclose = 1
let g:tagbar_compact = 2

" ----------------------------------------------------------------------
"   jlanzarotta/bufexplorer
" ----------------------------------------------------------------------
let g:bufExplorerDefaultHelp = 0
let g:bufExplorerSplitOutPathName = 0
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerDisableDefaultKeyMapping = 1

" ----------------------------------------------------------------------
"   fholgado/minibufexpl.vim
" ----------------------------------------------------------------------
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 0
let g:miniBufExplModSelTarget = 1
let g:miniBufExplUseSingleClick = 1

" ----------------------------------------------------------------------
"   ctrlpvim/ctrlp.vim
" ----------------------------------------------------------------------
let g:ctrlp_working_path_mode = 'wa'  " start from cwd instead of root
let g:ctrlp_switch_buffer = 0 "'et'
let g:ctrlp_show_hidden = 1

" Ignore files from .gitignore
" let g:ctrlp_user_command = {
"   \ 'fallback': 'cd %s && fd --hidden --type f',
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --others --exclude-standard'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ 3: ['.bzr', 'cd %s && bzr ls -R -k file'],
    \ },
  \ 'ignore': 1
  \ }


" ----------------------------------------------------------------------
"   plasticboy/vim-markdown
" ----------------------------------------------------------------------
let g:vim_markdown_follow_anchor = 1

" let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_level = 6

let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

let g:vim_markdown_strikethrough = 1
let g:vim_markdown_frontmatter = 1
" let g:vim_markdown_json_frontmatter = 1   " NOTE: Breaks links concealing!
" let g:vim_markdown_toml_frontmatter = 1

let g:vim_markdown_toc_autofit = 1

map <F13> <Plug>Markdown_EditUrlUnderCursor   " re-enable default <ge> mapping

" ----------------------------------------------------------------------
"   dhruvasagar/vim-table-mode
" ----------------------------------------------------------------------
let g:table_mode_verbose = 0

" ----------------------------------------------------------------------
"   dkarter/bullets.vim
" ----------------------------------------------------------------------
let g:bullets_checkbox_markers = '   X'
let g:bullets_checkbox_partials_toggle = 0
" Add another cycle or -/*/+
let g:bullets_outline_levels = [
      \ 'ROM', 'ABC',
      \ 'num', 'abc', 'rom',
      \ 'std-', 'std*', 'std+',
      \ 'std-', 'std*', 'std+'
      \]

" ----------------------------------------------------------------------
"   mtth/scratch.vim
" ----------------------------------------------------------------------
let g:scratch_insert_autohide = 0
let g:scratch_filetype = 'markdown'

" ----------------------------------------------------------------------
"   majutsushi/tagbar
" ----------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "context"

" ----------------------------------------------------------------------
"   ycm-core/YouCompleteMe
" ----------------------------------------------------------------------
let g:ycm_autoclose_preview_window_after_completion = 1
" only use the `Down` key to select the first item
let g:ycm_key_list_select_completion = ['<Down>']

" ----------------------------------------------------------------------
"   junegunn/vim-peekaboo
" ----------------------------------------------------------------------
let g:peekaboo_window = 'vert bo 40new'
let g:peekaboo_delay = 500

" ----------------------------------------------------------------------
"   lervag/wiki.vim
" ----------------------------------------------------------------------
let g:wiki_root = '~/projekty/wiki'
let wiki_global_load = 1
let g:wiki_link_toggle_on_follow = 0
let g:wiki_write_on_nav = 1

let g:wiki_toc_title = ''

let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'
let g:wiki_link_target_type = 'md'

" TODO: Update TOC on save (if exists!)
" See: https://github.com/mzlogin/vim-markdown-toc/blob/master/ftplugin/markdown.vim


" ----------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------

" Don't use Ex mode, use Q for formatting
map Q gq

" More logical yanking (like D, C)
map Y y$

" Reset highlighting
nnoremap <leader><space> :nohlsearch<cr>

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

" Increment (not to interfere with screen leader key)
nnoremap <C-C> <C-A>

" Fold using space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" scrooloose/nerdtree
nnoremap <leader>d :NERDTreeFocus<CR>
" Open NERDTree and show current file
nnoremap <leader>c :NERDTreeFind<CR>

" majutsushi/tagbar
nnoremap <leader>a :TagbarToggle<CR>

" jlanzarotta/bufexplorer
" nnoremap <leader>b :BufExplorer<CR>
nnoremap <leader>b :ToggleBufExplorer<CR>

" AndrewRadev/sideways.vim
" machakann/vim-swap
" NOTE: Sideways is more versatile, but Swap's interactive mode is so good! 
let g:swap_no_default_key_mappings = 1
nnoremap gh :SidewaysLeft<cr>
nnoremap gl :SidewaysRight<cr>
nnoremap gs <Plug>(swap-interactive)
" nmap <leader>si <Plug>SidewaysArgumentInsertBefore
" nmap <leader>sa <Plug>SidewaysArgumentAppendAfter
" nmap <leader>sI <Plug>SidewaysArgumentInsertFirst
" nmap <leader>sA <Plug>SidewaysArgumentAppendLast

" mtth/scratch.vim
let g:scratch_no_mappings = 1
nmap <leader>si <plug>(scratch-insert-reuse)
nmap <leader>sc <plug>(scratch-insert-clear)
xmap <leader>si <plug>(scratch-selection-reuse)
xmap <leader>sc <plug>(scratch-selection-clear)
nnoremap <leader>ss :Scratch<CR>
nnoremap <leader>sp :ScratchPreview<CR>

" dkarter/bullets.vim
autocmd FileType markdown
  \ nnoremap <buffer> <C-x> :ToggleCheckbox<CR>|
  \ imap <buffer> <C-l> <Plug>(bullets-demote) |
  \ imap <buffer> <C-h> <Plug>(bullets-promote)

" lervag/vim-rainbow-lists
autocmd FileType markdown
  \ nnoremap <buffer> <leader>r :RBListToggle<CR>

" lervag/wiki.vim
nnoremap <Tab> <Plug>(wiki-link-next)   " Not mapped for some reason...

nnoremap <leader>w<C-P> :execute 'CtrlP ' .. wiki#get_root()<CR>
nnoremap <leader>pw :execute 'CtrlP ' .. wiki#get_root()<CR>

" ctrlpvim/ctrlp.vim
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>pp :CtrlP<CR>
nnoremap <leader>pc :CtrlPCurFile<CR>
nnoremap <leader>pd :CtrlPCurWD<CR>
nnoremap <leader>pr :CtrlPRoot<CR>
nnoremap <leader>pm :CtrlPMRU<CR>
nnoremap <leader>pb :CtrlPBuffer<CR>
nnoremap <leader>pl :CtrlPLine<CR>

" tpope/vim-fugitive
" junegunn/gv.vim
nnoremap <leader>gv :GV!<CR>
nnoremap <leader>gl :Git log %<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gs :Git<CR>

" ycm-core/YouCompleteMe
" TODO: See: https://github.com/puremourning/.vim-mac/blob/master/plugin/ycm_mappings.vim


" ----------------------------------------------------------------------
" after a re-source, fix syntax matching issues (concealing brackets)
" ----------------------------------------------------------------------
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

