" .vimrc
" .vim/highlights.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" ----------------------------------------------------------------------
"  Colorscheme
"  NOTE: highlight by default is global
" ----------------------------------------------------------------------

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

