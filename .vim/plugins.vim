" .vimrc
" .vim/plug.vim
" .vim/plugins.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" ----------------------------------------------------------------------
"  Plugins settings
" ----------------------------------------------------------------------

" ----------------------------------------------------------------------
"   tpope/vim-unimpaired
" ----------------------------------------------------------------------
" Disable option toggling
let g:nremap = {
      \ '=s': '', '>s': '', '<s': '',
      \ '[o': '', ']o': '', 'yo': '',
      \}


" ----------------------------------------------------------------------
"   airblade/vim-rooter
" ----------------------------------------------------------------------
let g:rooter_manual_only = 1
let g:rooter_cd_cmd = 'lcd'
let g:rooter_silent_chdir = 1


" ----------------------------------------------------------------------
"   lambdalisue/fern.vim
" ----------------------------------------------------------------------
let g:fern#default_hidden = 1
let g:fern#drawer_width = 40
let g:fern#drawer_hover_popup_delay = 100
let g:fern#scheme#file#show_absolute_path_on_root_label = 1

let g:fern#disable_default_mappings = 1

let g:fern#renderer#default#leading = '  '
let g:fern#renderer#default#leaf_symbol = '  '  " NOTE: non-breaking space!
let g:fern#renderer#default#collapsed_symbol = '▸ '
let g:fern#renderer#default#expanded_symbol = '▾ '

" let g:fern#renderer = "nerdfont"
let g:fern#renderer#nerdfont#indent_markers = 0
let g:fern#renderer#nerdfont#leading = '  '

" let g:fern#renderer = "devicons"
let g:fern#renderer#devicons#leading = '  '

let g:fern#renderer = 'lsflavor'

" let g:fern#renderer = "plain"

function! s:init_fern() abort
  " Write custom code here
  setlocal nonumber
  setlocal signcolumn=auto
endfunction

augroup my-fern
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END


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

if exists('g:loaded_webdevicons') == 0
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
endif


" ----------------------------------------------------------------------
"   majutsushi/tagbar
" ----------------------------------------------------------------------
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 2
let g:tagbar_show_tag_count = 1


" ----------------------------------------------------------------------
"   jlanzarotta/bufexplorer
" ----------------------------------------------------------------------
let g:bufExplorerDefaultHelp = 0
let g:bufExplorerSplitOutPathName = 0
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerFindActive = 0


" ----------------------------------------------------------------------
"   ctrlpvim/ctrlp.vim
" ----------------------------------------------------------------------
let g:ctrlp_working_path_mode = 'wa'  " start from cwd instead of root
let g:ctrlp_switch_buffer = 0 "'Et'
let g:ctrlp_show_hidden = 1
let g:ctrlp_match_current_file = 1

" Increase number of results
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100'

let g:ctrlp_lazy_update = 100

let g:fruzzy#usenative = 1
let g:cpsm_highlight_mode = 'detailed'
let g:cpsm_query_inverting_delimiter = ' '
" let g:ctrlp_match_func = {'match': 'fruzzy#ctrlp#matcher'}
" let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}
" let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
" let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}

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
"   dyng/ctrlsf.vim
" ----------------------------------------------------------------------
let g:ctrlsf_auto_focus = {
    \ "at" : "start",
    \ "duration_less_than": 1000
    \ }

let g:ctrlsf_auto_close = {
    \ "normal" : 0,
    \ "compact": 1
    \}

let g:ctrlsf_case_sensitive = 'smart'

let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_compact_winsize = 10

let g:ctrlsf_indent = 2

" let g:ctrlsf_default_root = 'project+ww'
let g:ctrlsf_default_root = 'cwd'

let g:ctrlsf_populate_qflist = 1

let g:ctrlsf_extra_backend_args = {
    \ 'rg': '--hidden'
    \ }


" ----------------------------------------------------------------------
"   junegunn/fzf
"   junegunn/fzf.vim
" ----------------------------------------------------------------------
let g:fzf_command_prefix = 'Fzf'

let g:fzf_layout = { 'down': '11' }
" let g:fzf_preview_window = []
let g:fzf_preview_window = ['hidden,border-none,right,50%', 'ctrl-/']

let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Identifier'],
    \ 'fg+':     ['fg', 'FzfCurrentItem'],
    \ 'bg+':     ['bg', 'FzfCurrentItem'],
    \ 'hl+':     ['fg', 'Identifier'],
    \ 'info':    ['fg', 'Comment'],
    \ 'separator':  ['fg', 'FzfSeparator'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'query':   ['fg', 'Normal'],
    \ 'pointer': ['fg', 'Comment'],
    \ 'marker':  ['fg', 'Constant'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'],
    \}

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" NOTE: C-S may clash with toggle-sort
let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit',
    \}

function! s:fzf_statusline()
  " Override statusline as you like
  setlocal statusline=%#StatusLine#\ >\ fz%#StatusLineNC#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Fzf commands
" See: https://vi.stackexchange.com/questions/20842/how-can-i-merge-two-dictionaries-in-vim
" TODO: declare commands using g:fzf_command_prefix
command! -bang FzfDirFiles
  \ call fzf#vim#files(fnamemodify(dirs#Dir(), ':~:.'), fzf#vim#with_preview(), <bang>0)
command! -bang FzfCWDFiles
  \ call fzf#vim#files(fnamemodify(dirs#CWD(), ':~'), fzf#vim#with_preview(), <bang>0)
command! -bang FzfLocalCWDFiles
  \ call fzf#vim#files(fnamemodify(dirs#LocalCWD(), ':~'), fzf#vim#with_preview(), <bang>0)
command! -bang FzfGlobalCWDFiles
  \ call fzf#vim#files(fnamemodify(dirs#GlobalCWD(), ':~'), fzf#vim#with_preview(), <bang>0)
command! -bang FzfRootDirFiles
  \ call fzf#vim#files(fnamemodify(dirs#RootDir(), ':~'), fzf#vim#with_preview(), <bang>0)
command! -bang FzfProjectsDirFiles
  \ call fzf#vim#files(fnamemodify(dirs#ProjectsDir(), ':~'), fzf#vim#with_preview(), <bang>0)


" ----------------------------------------------------------------------
"   pbogut/fzf-mru.vim
" ----------------------------------------------------------------------
let g:fzf_mru_relative = 1
let g:fzf_mru_no_sort = 1
let g:fzf_mru_exclude_current_file = 0


" ----------------------------------------------------------------------
"   plasticboy/vim-markdown
" ----------------------------------------------------------------------
let g:vim_markdown_follow_anchor = 1

let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_level = 6

" Auto insert bullets for Shift-O to work, and indent=2 for textwrap
" NOTE: But this breaks formatoptions+=a setting for automatic reformatting
"       when text is added in the middle of line
let g:vim_markdown_auto_insert_bullets = 0    " = 1
let g:vim_markdown_new_list_item_indent = 0   " = 2

let g:vim_markdown_strikethrough = 1
let g:vim_markdown_frontmatter = 1
" let g:vim_markdown_json_frontmatter = 1   " NOTE: Breaks links concealing!
" let g:vim_markdown_toml_frontmatter = 1

let g:vim_markdown_toc_autofit = 1


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
" and use only num; ROM, ABC, rom, abc are not rendered correctly
let g:bullets_outline_levels = [
      \ 'num', 'num', 'num', 'num',
      \ 'std-', 'std*', 'std+',
      \ 'std-', 'std*', 'std+'
      \]


" ----------------------------------------------------------------------
"   mtth/scratch.vim
" ----------------------------------------------------------------------
let g:scratch_insert_autohide = 0
let g:scratch_filetype = 'markdown'
let g:scratch_height = 10


" ----------------------------------------------------------------------
"   tmhedberg/simpylfold
" ----------------------------------------------------------------------
let g:SimpylFold_docstring_preview = 1


" ----------------------------------------------------------------------
"   ycm-core/YouCompleteMe
" ----------------------------------------------------------------------
" let g:ycm_add_preview_to_completeopt="popup"
let g:ycm_autoclose_preview_window_after_completion = 1

" Turn semantic completion for specific filetypes
" NOTE: Use g:ycm_filetype_blacklist to completely turn off YCM instead
let g:ycm_filetype_specific_completion_to_disable = {
      \ 'gitcommit': 1
      \}


" ----------------------------------------------------------------------
"   ervandew/supertab
" ----------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "context"

let g:SuperTabRetainCompletionDuration = "completion"

let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 0

" NOTE: Default <c-p> messes up with YCM
let g:SuperTabContextDefaultCompletionType = "<c-n>"


" ----------------------------------------------------------------------
"   mhinz/vim-signify
" ----------------------------------------------------------------------
let g:signify_disable_by_default = 1

let g:signify_number_highlight = 0
let g:signify_line_highlight = 0

function! s:show_current_hunk() abort
  let h = sy#util#get_hunk_stats()
  if !empty(h)
    echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
  endif
endfunction

augroup signifyHunks
  au!
  " NOTE: Not sure why won't work when in .vim/autoload/signify.vim
  autocmd User SignifyHunk call s:show_current_hunk()
augroup END


" ----------------------------------------------------------------------
"   junegunn/vim-peekaboo
" ----------------------------------------------------------------------
let g:peekaboo_window = 'vert bo 40new'
let g:peekaboo_delay = 500


" ----------------------------------------------------------------------
"   lervag/wiki.vim
" ----------------------------------------------------------------------
let g:wiki_root = '~/projekty/wiki'

" Use Markdown format
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'
let g:wiki_link_target_type = 'md'

" Enable on all wiki_filetypes
let g:wiki_global_load = 1

" Do NOT toggle link when using follow lik mapping
" OR at least not when using <Enter> to follow
let g:wiki_link_toggle_on_follow = 0

" Write before navigating from file
let g:wiki_write_on_nav = 1

" NOTE: special characters like '' break pandoc export
let g:wiki_toc_title = 'TOC:'

" Let's make sure filenames are consistent
let g:wiki_map_text_to_link = 'WikiTextToLink'
let g:wiki_map_create_page = 'WikiCreatePage'

function WikiLinkFormat(text) abort
  return substitute(tolower(a:text), '\s\+', '_', 'g')
endfunction

function WikiTextToLink(text) abort
  return [WikiLinkFormat(a:text), a:text]
endfunc

function WikiCreatePage(name) abort
  return wiki#get_root() . '/' . WikiLinkFormat(a:name)
endfunc


" ----------------------------------------------------------------------
"   mzlogin/vim-markdown-toc
" ----------------------------------------------------------------------
let g:vmt_auto_update_on_save = 0

let g:vmt_fence_text = 'toc'
let g:vmt_fence_closing_text = '/toc'
let g:vmt_fence_hidden_markdown_style = 'GFM'

let g:vmt_list_indent_text = '  '


" ----------------------------------------------------------------------
"   alvan/vim-closetag
" ----------------------------------------------------------------------
let g:closetag_filetypes = 'html,xhtml,phtml,markdown'
let g:closetag_close_shortcut = '/>' " Use //> to type />


" ----------------------------------------------------------------------
" 	skammer/vim-css-color
" ----------------------------------------------------------------------
let g:cssColorVimDoNotMessMyUpdatetime = 1


" ----------------------------------------------------------------------
" 	wellle/targets.vim
" ----------------------------------------------------------------------
" Only consider targets fully contained in current line
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr ll'


" ----------------------------------------------------------------------
"   junegunn/goyo.vim
"   junegunn/limelight.vim
" ----------------------------------------------------------------------
let g:limelight_conceal_ctermfg = 'gray'
" let g:limelight_conceal_ctermfg = 240

augroup GoyoLimelightIntegration
  au! *
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END

