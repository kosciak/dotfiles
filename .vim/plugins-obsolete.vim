" .vimrc
" .vim/plugins.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" ----------------------------------------------------------------------
"  Plugins settings
" ----------------------------------------------------------------------

" ----------------------------------------------------------------------
"   rhysd/clever-f.vim
" ----------------------------------------------------------------------
let g:clever_f_show_prompt = 1
let g:clever_f_highlight_timeout_ms=1000

" ----------------------------------------------------------------------
"   fholgado/minibufexpl.vim
" ----------------------------------------------------------------------
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 0
let g:miniBufExplModSelTarget = 1
let g:miniBufExplUseSingleClick = 1

" ----------------------------------------------------------------------
"   airblade/vim-gitgutter
" ----------------------------------------------------------------------
let g:gitgutter_enabled = 0   " Turn off by default
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '__'

" ----------------------------------------------------------------------
"   Xuyuanp/nerdtree-git-plugin
" ----------------------------------------------------------------------
let g:NERDTreeGitStatusCwdOnly = 1
let g:NERDTreeGitStatusUseNerdFonts = 0
let g:NERDTreeGitStatusShowClean = 0
let g:NERDTreeGitStatusAlignIfConceal = 0


" ----------------------------------------------------------------------
"   Yggdroot/LeaderF
" ----------------------------------------------------------------------
let g:Lf_WindowPosition = 'popup'
let g:Lf_WindowHeight = 10
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_ReverseOrder = 1

