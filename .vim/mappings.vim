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
nnoremap <leader>P :setlocal invpaste paste?<CR>
set pastetoggle=<leader>P

" Toggle between spell and nospell
nnoremap <leader>S :setlocal spell! spell?<CR>

" Toggle beteen list and nolist
nnoremap <leader>L :setlocal list! list?<CR>

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

" Splits
nnoremap <silent> <leader>s :sp<CR>
nnoremap <silent> <leader>v :vs<CR>

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
" TODO: File Explorer mappings need some leader key!
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>r :NERDTreeVCS<CR>
nnoremap <leader>d :NERDTreeCWD<CR>
nnoremap <leader>c :NERDTreeFind<CR>

let g:NERDTreeMapOpenSplit = 's'    " Remap split to 's'
let g:NERDTreeMapOpenVSplit = 'v'   " Remap vertical split to 'v'


" ----------------------------------------------------------------------
"   majutsushi/tagbar
" ----------------------------------------------------------------------
nnoremap <leader>a :TagbarOpen fj<CR>
nnoremap <leader>A :TagbarClose<CR>


" ----------------------------------------------------------------------
"   jlanzarotta/bufexplorer
" ----------------------------------------------------------------------
let g:bufExplorerDisableDefaultKeyMapping = 1
" nnoremap <leader>b :BufExplorer<CR>
nnoremap <leader>b :ToggleBufExplorer<CR>
" nnoremap <leaderbb :ToggleBufExplorer<CR>
" nnoremap <leader>bv :BufExplorerVerticalSplit<CR>
" nnoremap <leader>bs :BufExplorerHorizontalSplit<CR>


" ----------------------------------------------------------------------
"   mtth/scratch.vim
" ----------------------------------------------------------------------
let g:scratch_no_mappings = 1
" TODO: consider <leader>` or even <leader>~
nnoremap <leader>` :Scratch<CR>
nnoremap <leader>~ :ScratchPreview<CR>
" nmap <leader>si <plug>(scratch-insert-reuse)
" nmap <leader>sc <plug>(scratch-insert-clear)
" xmap <leader>si <plug>(scratch-selection-reuse)
" xmap <leader>sc <plug>(scratch-selection-clear)
" nnoremap <leader>ss :Scratch<CR>
" nnoremap <leader>sp :ScratchPreview<CR>


" ----------------------------------------------------------------------
"   AndrewRadev/sideways.vim
"   machakann/vim-swap
" ----------------------------------------------------------------------
" NOTE: Sideways is more versatile, but Swap's interactive mode is so good!
let g:swap_no_default_key_mappings = 1

nmap gsh <Plug>SidewaysLeft
nmap gsl <Plug>SidewaysRight
nnoremap gsj :SidewaysJumpRight<CR>
nnoremap gsk :SidewaysJumpLeft<CR>
nmap gss <Plug>(swap-interactive)
nmap gsi <Plug>SidewaysArgumentInsertBefore
nmap gsa <Plug>SidewaysArgumentAppendAfter
nmap gsI <Plug>SidewaysArgumentInsertFirst
nmap gsA <Plug>SidewaysArgumentAppendLast


" ----------------------------------------------------------------------
"   dkarter/bullets.vim
" ----------------------------------------------------------------------
nnoremap <silent> <Plug>BulletsDemoteMapping :BulletDemote<CR>
            \:call repeat#set("\<Plug>BulletsDemoteMapping")<CR>
nnoremap <silent> <Plug>BulletsPromoteMapping :BulletPromote<CR>
            \:call repeat#set("\<Plug>BulletsPromoteMapping")<CR>

" Support for repeated mappings
let g:bullets_custom_mappings = [
      \ ['nmap', '>>', '<Plug>BulletsDemoteMapping'],
      \ ['nmap', '<<', '<Plug>BulletsPromoteMapping'],
      \]


" ----------------------------------------------------------------------
"   dhruvasagar/vim-table-mode
" ----------------------------------------------------------------------
let g:table_mode_disable_tableize_mappings = 1
let g:table_mode_map_prefix = '<leader><C-T>'
let g:table_mode_toggle_map = '<C-T>'
let g:table_mode_insert_column_before_map = '<leader>tic'
let g:table_mode_insert_column_after_map = '<leader>tac'
let g:table_mode_motion_left_map = '[\'         " '[<Bar>'
let g:table_mode_motion_right_map = ']\'        " ']<Bar>'
let g:table_mode_motion_up_map = '[<Bar>'       " '{<Bar>'
let g:table_mode_motion_down_map = ']<Bar>'     " '}<Bar>'
let g:table_mode_cell_text_object_a_map = 'a\'  " 'a<Bar>'
let g:table_mode_cell_text_object_i_map = 'i\'  " 'i<Bar>'


" ----------------------------------------------------------------------
"   plasticboy/vim-markdown
" ----------------------------------------------------------------------
map [h <Plug>Markdown_MoveToCurHeader
map [u <Plug>Markdown_MoveToParentHeader

" re-enable default <ge> mapping
map <Plug> <Plug>Markdown_EditUrlUnderCursor


" ----------------------------------------------------------------------
"   lervag/wiki.vim
"   mzlogin/vim-markdown-toc
" ----------------------------------------------------------------------
nnoremap <silent> <Plug>WikiLinkToggleMapping :WikiLinkToggle<CR>
            \:call repeat#set("\<Plug>WikiLinkToggleMapping")<CR>

nnoremap <silent> <Plug>WikiLinkExtractHeaderMapping :WikiLinkExtractHeader<CR>
            \:call repeat#set("\<Plug>WikiLinkExtractHeaderMapping")<CR>

" g:wiki_mappings_global, g:wiki_mappings_local
let g:wiki_mappings_local = {
      \ '<plug>(wiki-link-follow-split)': '<leader>ws',
      \ '<plug>(wiki-link-follow-vsplit)': '<leader>wv',
      \ 'x_<plug>(wiki-link-toggle-visual)': 'gl',
      \ '<plug>(wiki-link-toggle)': '',
      \ '<plug>(wiki-page-toc)': '',
      \ '<plug>(wiki-page-toc-local)': '',
      \ '<plug>(wiki-tag-list)': '',
      \ '<plug>(wiki-tag-search)': '',
      \ '<plug>(wiki-tag-reload)': '',
      \ '<plug>(wiki-tag-rename)': '',
      \ '<plug>(wiki-link-show)': '',
      \ '<plug>(wiki-link-extract-header)': '',
      \ '<plug>(wiki-export)': '',
      \ 'x_<plug>(wiki-export)': '',
      \}

function! s:WikiBufferInit() abort
  nnoremap <buffer> <leader>wh <Plug>WikiLinkExtractHeaderMapping
  nnoremap <buffer> <leader>wl <Plug>WikiLinkToggleMapping
  nnoremap <buffer> <leader>wf <Plug>(wiki-link-follow)
  nnoremap <buffer> <leader>wT :GenTocGFM<CR>
  nnoremap <buffer> <leader>wt :UpdateToc<CR>
  nnoremap <buffer> <leader>fh <plug>(wiki-fzf-toc)
endfunc

augroup wikiLocalMappings
  au!
  autocmd User WikiBufferInitialized call s:WikiBufferInit()
augroup END

nnoremap <leader>ow :execute 'CtrlP ' .. dirs#WikiRootDir()<CR>
nnoremap <leader>wo :execute 'CtrlP ' .. dirs#WikiRootDir()<CR>
nnoremap <leader>w<C-P> :execute 'CtrlP ' .. dirs#WikiRootDir()<CR>


" ----------------------------------------------------------------------
"   ctrlpvim/ctrlp.vim
" ----------------------------------------------------------------------
" TODO: Consider using <leader>f (find) instead of <leader>o (open), although
"       it might be better to use <leader>f for searching with ctrlsf
nnoremap <leader>o :CtrlP<CR>
nnoremap <leader>of :CtrlPCurFile<CR>
nnoremap <leader>od :CtrlPCurWD<CR>
nnoremap <leader>or :CtrlPRoot<CR>
nnoremap <leader>op :CtrlP ~/projekty<CR>

nnoremap <leader>om :CtrlPMRU<CR>

nnoremap <leader>oa :CtrlPBufTag<CR>
nnoremap <leader>oA :CtrlPBufTagAll<CR>

nnoremap <leader>ol :CtrlPLine %<CR>
nnoremap <leader>oL :CtrlPLine<CR>

nnoremap <leader>ob :CtrlPBuffer<CR>


" ----------------------------------------------------------------------
"   dyng/ctrlsf.vim
" ----------------------------------------------------------------------
nmap <leader>/ <Plug>CtrlSFPrompt


" ----------------------------------------------------------------------
"   junegunn/fzf
"   junegunn/fzf.vim
" ----------------------------------------------------------------------
nnoremap <leader>F :FZF<space>
nnoremap <leader>fF :FZF<space>

nnoremap <leader>ff :FzfDirFiles<CR>
nnoremap <leader>fd :FzfCWDFiles<CR>
nnoremap <leader>fr :FzfRootDirFiles<CR>
nnoremap <leader>fp :FzfProjectsDirFiles<CR>

nnoremap <leader>fm :FZFMru<CR>

nnoremap <leader>fa :FzfBTags<CR>
nnoremap <leader>fA :FzfTags<CR>

nnoremap <leader>fl :FzfBLines<CR>
nnoremap <leader>fL :FzfLines<CR>

nnoremap <leader>fb :FzfBuffers<CR>

nnoremap <leader>f/ :FzfHistory/<CR>
nnoremap <leader>f: :FzfHistory:<CR>

nnoremap <leader>fH :FzfHelptags<CR>

nnoremap <leader>fw <plug>(wiki-fzf-pages)

nnoremap <leader>fS :FzfGFiles?<CR>


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

nnoremap <silent> <leader>' :SignifyHunkDiff<CR>

" nmap ]c <Plug>(GitGutterNextHunk)
" nmap [c <Plug>(GitGutterPrevHunk)


" ----------------------------------------------------------------------
"   ycm-core/YouCompleteMe
" ----------------------------------------------------------------------
" TODO: See: https://github.com/puremourning/.vim-mac/blob/master/plugin/ycm_mappings.vim

" only use the `Down` key to select the first item
" let g:ycm_key_list_select_completion = ['<Tab>', '<Down>']
let g:ycm_key_list_select_completion = ['<Down>']

" TODO: Do NOT overwrite original mapping to insert previously inserted text
" NOTE: Well... invoking completion seems important, so until I fin other key
"       that might be used instead le'ts use Ctrl-Space.
"       To get default behaviour use C-A in instert mode instead
let g:ycm_key_invoke_completion = '<C-@>'

nmap <leader>D <plug>(YCMHover)


" nnoremap <silent> <leader>f :Fern . -drawer -reveal=% -toggle<CR>
