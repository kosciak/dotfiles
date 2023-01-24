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

" Don't use Ex mode, use Q for formatting
map Q gq

" More logical yanking (like D, C)
map Y y$

" Reset highlighting
nnoremap <leader><space> :nohlsearch<cr>

" Forward f, F, t, T
nnoremap , ;
" Backward f, F, t, T
nnoremap \ ,

" Reload .vimrc
nnoremap <leader><C-R> :source $MYVIMRC<CR>:echo "Reloaded .vimrc"<CR>

" Toggle between paste and nopaste, with visual feedback
nnoremap <leader>p :set invpaste paste?<CR>
set pastetoggle=<leader>p

" Split navigations without pressing Ctrl-W first
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
nnoremap <leader>ow :execute 'CtrlP ' .. wiki#get_root()<CR>
nnoremap <leader>wo :execute 'CtrlP ' .. wiki#get_root()<CR>
nnoremap <leader>w<C-P> :execute 'CtrlP ' .. wiki#get_root()<CR>

" ctrlpvim/ctrlp.vim
nnoremap <leader>o :CtrlP<CR>
nnoremap <leader>oo :CtrlP<CR>
nnoremap <leader>oc :CtrlPCurFile<CR>
nnoremap <leader>od :CtrlPCurWD<CR>
nnoremap <leader>or :CtrlPRoot<CR>
nnoremap <leader>om :CtrlPMRU<CR>
nnoremap <leader>ob :CtrlPBuffer<CR>
nnoremap <leader>ol :CtrlPLine<CR>

" tpope/vim-fugitive
" junegunn/gv.vim
nnoremap <leader>gv :GV!<CR>
nnoremap <leader>gl :Git log %<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gs :Git<CR>

" ycm-core/YouCompleteMe
" TODO: See: https://github.com/puremourning/.vim-mac/blob/master/plugin/ycm_mappings.vim

