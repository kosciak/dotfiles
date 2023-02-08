" .vimrc
" .vim/mappings.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" ----------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------

" let mapleader = ','
let mapleader = ';'

" Forward f, F, t, T
nnoremap , ;
vnoremap , ;
onoremap , ;
" Backward f, F, t, T
nnoremap \ ,
vnoremap \ ,
onoremap \ ,

" Don't use Ex mode, use Q for formatting
map Q gq

" More logical yanking (like D, C)
map Y y$

" Reset highlighting
nnoremap <leader><space> :nohlsearch<cr>

" Reload .vimrc
nnoremap <leader><C-R> :source $MYVIMRC<CR>:echo "Reloaded "..fnamemodify($MYVIMRC,':p:~')<CR>

" Toggle between paste and nopaste, with visual feedback
nnoremap <leader>P :set invpaste paste?<CR>
set pastetoggle=<leader>P

" Toggle between spell and nospell
nnoremap <leader>S :setlocal spell! spell?<CR>

" Split navigations without pressing Ctrl-W first
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Increase and decrease size without pressing Shift
nnoremap <C-W>+ <C-W>=
nnoremap <C-W>= <C-W>+

" Resize windows using Ctrl+arrows
nnoremap <silent> <C-UP> :resize +2<CR>
nnoremap <silent> <C-DOWN> :resize -2<CR>
nnoremap <silent> <C-LEFT> :vertical resize -2<CR>
nnoremap <silent> <C-RIGHT> :vertical resize +2<CR>

" A bit more logical windowm switching
" Switch between previous/next window
nnoremap <C-W><C-W> <C-W><C-P>
nnoremap <C-W>w <C-W>p
" Move to next window
nnoremap <C-W>n <C-W>w
nnoremap <C-W><C-N> <C-W><C-W>
" Move to previous window
nnoremap <C-W>p <C-W>W
nnoremap <C-W><C-P> <C-W>W
" Create new window
nnoremap <C-W>N <C-W>n

" Close window
nnoremap <silent> <leader>q :close<CR>

" Increment (not to interfere with screen leader key)
" nnoremap <C-C> <C-A>
nmap <C-C> <C-A>

" Fold using space
" nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>


" ----------------------------------------------------------------------
"   ton/vim-bufsurf
" ----------------------------------------------------------------------
" Go to previous file
nnoremap <silent> <leader><C-O> <Plug>(buf-surf-back)
nnoremap <silent> <leader><C-I> <Plug>(buf-surf-forward)


" ----------------------------------------------------------------------
"   scrooloose/nerdtree
" ----------------------------------------------------------------------
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>r :NERDTreeVCS<CR>
nnoremap <leader>d :NERDTreeCWD<CR>
nnoremap <leader>c :NERDTreeFind<CR>


" ----------------------------------------------------------------------
"   majutsushi/tagbar
" ----------------------------------------------------------------------
nnoremap <leader>a :TagbarOpen fj<CR>
nnoremap <leader>A :TagbarClose<CR>


" ----------------------------------------------------------------------
"   jlanzarotta/bufexplorer
" ----------------------------------------------------------------------
" nnoremap <leader>b :BufExplorer<CR>
nnoremap <leader>b :ToggleBufExplorer<CR>
nnoremap <leader>bb :ToggleBufExplorer<CR>
nnoremap <leader>bv :BufExplorerVerticalSplit<CR>
nnoremap <leader>bs :BufExplorerHorizontalSplit<CR>


" ----------------------------------------------------------------------
"   AndrewRadev/sideways.vim
"   machakann/vim-swap
" ----------------------------------------------------------------------
" NOTE: Sideways is more versatile, but Swap's interactive mode is so good! 
let g:swap_no_default_key_mappings = 1
nnoremap gsh :SidewaysLeft<CR>
nnoremap gsl :SidewaysRight<CR>
nnoremap gsj :SidewaysJumpRight<CR>
nnoremap gsk :SidewaysJumpLeft<CR>
nnoremap gss <Plug>(swap-interactive)
nmap gsi <Plug>SidewaysArgumentInsertBefore
nmap gsa <Plug>SidewaysArgumentAppendAfter
nmap gsI <Plug>SidewaysArgumentInsertFirst
nmap gsA <Plug>SidewaysArgumentAppendLast


" ----------------------------------------------------------------------
"   mtth/scratch.vim
" ----------------------------------------------------------------------
let g:scratch_no_mappings = 1
nmap <leader>si <plug>(scratch-insert-reuse)
nmap <leader>sc <plug>(scratch-insert-clear)
xmap <leader>si <plug>(scratch-selection-reuse)
xmap <leader>sc <plug>(scratch-selection-clear)
nnoremap <leader>ss :Scratch<CR>
nnoremap <leader>sp :ScratchPreview<CR>


" ----------------------------------------------------------------------
"   dkarter/bullets.vim
" ----------------------------------------------------------------------
nnoremap <silent> <Plug>BulletsDemoteMapping :BulletDemote<CR>
            \:call repeat#set("\<Plug>BulletsDemoteMapping")<CR>
nnoremap <silent> <Plug>BulletsPromoteMapping :BulletPromote<CR>
            \:call repeat#set("\<Plug>BulletsPromoteMapping")<CR>

autocmd FileType markdown
  \ nnoremap <buffer> <C-X> <Plug>(bullets-toggle-checkbox)|
  \ imap <buffer> <C-L> <Plug>(bullets-demote)|
  \ imap <buffer> <C-H> <Plug>(bullets-promote)


" ----------------------------------------------------------------------
"   lervag/wiki.vim
" ----------------------------------------------------------------------
nnoremap <silent> <Plug>WikiLinkToggleMapping :WikiLinkToggle<CR>
            \:call repeat#set("\<Plug>WikiLinkToggleMapping")<CR>

nnoremap <silent> <Plug>WikiLinkExtractHeaderMapping :WikiLinkExtractHeader<CR>
            \:call repeat#set("\<Plug>WikiLinkExtractHeaderMapping")<CR>

nnoremap <leader>wf <Plug>WikiLinkToggleMapping
nnoremap <leader>wh <Plug>WikiLinkExtractHeaderMapping

nnoremap <leader>ow :execute 'CtrlP ' .. wiki#get_root()<CR>
nnoremap <leader>wo :execute 'CtrlP ' .. wiki#get_root()<CR>
nnoremap <leader>w<C-P> :execute 'CtrlP ' .. wiki#get_root()<CR>


" ----------------------------------------------------------------------
"   ctrlpvim/ctrlp.vim
" ----------------------------------------------------------------------
" TODO: Consider using <leader>f (find) instead of <leader>o (open), although
"       it might be better to use <leader>f for searching with ctrlsf
nnoremap <leader>o :CtrlP<CR>
nnoremap <leader>oo :CtrlP<CR>
nnoremap <leader>oc :CtrlPCurFile<CR>
nnoremap <leader>od :CtrlPCurWD<CR>
nnoremap <leader>or :CtrlPRoot<CR>
nnoremap <leader>om :CtrlPMRU<CR>

nnoremap <leader>oa :CtrlPBufTag<CR>
nnoremap <leader>oA :CtrlPBufTagAll<CR>

nnoremap <leader>ol :CtrlPLine %<CR>
nnoremap <leader>oL :CtrlPLine<CR>

nnoremap <leader>ob :CtrlPBuffer<CR>
nnoremap <leader>bo :CtrlPBuffer<CR>
nnoremap <leader>b<C-P> :CtrlPBuffer<CR>


" ----------------------------------------------------------------------
"   tpope/vim-fugitive
"   junegunn/gv.vim
"   airblade/vim-gitgutter
"   mhinz/vim-signify
" ----------------------------------------------------------------------
nnoremap <leader>gv :GV!<CR>
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gl :Git log %<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
" nnoremap <leader>gc :GitGutterBufferToggle<CR>
" NOTE: SignifyToggle* works for current buffer only
nnoremap <silent> <leader>gc :SignifyToggle<CR>
nnoremap <silent> <leader>gC :SignifyToggleHighlight<CR>

nnoremap <silent> <leader>? :SignifyHunkDiff<CR>

" nmap ]c <Plug>(GitGutterNextHunk)
" nmap [c <Plug>(GitGutterPrevHunk)


" ----------------------------------------------------------------------
"   ycm-core/YouCompleteMe
" ----------------------------------------------------------------------
" TODO: See: https://github.com/puremourning/.vim-mac/blob/master/plugin/ycm_mappings.vim

nmap <leader>D <plug>(YCMHover)

