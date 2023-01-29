" .vimrc
" .vim/plugins.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
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
"   ctrlpvim/ctrlp.vim
" ----------------------------------------------------------------------
let g:ctrlp_working_path_mode = 'wa'  " start from cwd instead of root
let g:ctrlp_switch_buffer = 0 "'Et'
let g:ctrlp_show_hidden = 1
let g:ctrlp_match_current_file = 1
" Increase number of results
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100'

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
" and use only num; ROM, ABC, rom, abc are not rendered correctly
let g:bullets_outline_levels = [
      \ 'num', 'num', 'num', 'num',
      \ 'std-', 'std*', 'std+',
      \ 'std-', 'std*', 'std+'
      \]

" Create bullet in new line above (when in the middle of list)
let g:bullets_custom_mappings = [
    \ ['nmap', 'O', 'k<Plug>(bullets-newline)'],
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
let g:SuperTabContextDefaultCompletionType = "<c-n>"


" ----------------------------------------------------------------------
"   ycm-core/YouCompleteMe
" ----------------------------------------------------------------------
let g:ycm_autoclose_preview_window_after_completion = 1
" only use the `Down` key to select the first item
" let g:ycm_key_list_select_completion = ['<Tab>', '<Down>']
let g:ycm_key_list_select_completion = ['<Down>']

" Do NOT overwrite original mapping to insert previously inserted text
let g:ycm_key_invoke_completion = ''

" Turn semantic completion for specific filetypes
" NOTE: Use g:ycm_filetype_blacklist to completely turn off YCM instead
let g:ycm_filetype_specific_completion_to_disable = {
      \ 'javascript': 1,
      \ 'gitcommit': 1
      \}


" ----------------------------------------------------------------------
"   mhinz/vim-signify
" ----------------------------------------------------------------------
let g:signify_disable_by_default = 1
let g:signify_number_highlight = 1

augroup signifyHunks
  " NOTE: Not sure why won't work when in .vim/autoload/signify.vim
  " Reset current group to prevent problems with (re)sourcing .vimrc
  au!

  autocmd User SignifyHunk call s:show_current_hunk()

  function! s:show_current_hunk() abort
    let h = sy#util#get_hunk_stats()
    if !empty(h)
      echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
    endif
  endfunction

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
"   'alvan/vim-closetag'
" ----------------------------------------------------------------------
let g:closetag_filetypes = 'html,xhtml,phtml,markdown'
let g:closetag_close_shortcut = '/>' " Use //> to type />


" ----------------------------------------------------------------------
"   'junegunn/goyo.vim'
"   'junegunn/limelight.vim'
" ----------------------------------------------------------------------
let g:limelight_conceal_ctermfg = 'gray'
" let g:limelight_conceal_ctermfg = 240

augroup GoyoLimelight
  au!
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END


" ----------------------------------------------------------------------
"  OBSOLETE plugins
"  Keep settings in case I want to use them again
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

