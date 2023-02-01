" .vimrc
" .vim/highlights.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" ----------------------------------------------------------------------
"  Colorscheme and Highlights
"  NOTE: highlight by default is global
" ----------------------------------------------------------------------

"highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

" hi SpecialKey term=bold ctermfg=7 guifg=Blue
" hi NonText term=bold ctermfg=7 gui=bold guifg=Blue

hi CursorLine                 cterm=NONE  ctermbg=254
hi CursorLineNR   term=bold   cterm=bold  ctermbg=254

" hi StatusLineNormal cterm=reverse,italic
hi StatusLineNormal   cterm=reverse

hi bufExplorerMapping   term=bold   ctermfg=6   guifg=Cyan

hi TagbarScope          cterm=bold  ctermfg=5
hi TagbarAccessPublic               ctermfg=70

" Markup - bold headers
hi htmlTitle  term=bold   cterm=bold  ctermfg=5   gui=bold guifg=Magenta
hi htmlH1     term=bold   cterm=bold  ctermfg=5   gui=bold guifg=Magenta

" Markup - list markers
hi mkdListItem          term=bold   cterm=bold  ctermfg=2     gui=bold guifg=Green
hi mkdRule              term=bold   cterm=bold  ctermfg=2     gui=bold guifg=Green
" with bold checkboxes: [ ] [x]
hi mkdListItemCheckbox  term=bold   cterm=bold  ctermbg=254   gui=bold
hi mkdHeading           term=bold   cterm=bold  ctermbg=254   gui=bold

" Diff
hi diffAdded                              ctermfg=2   guifg=Green
hi diffRemoved                            ctermfg=1   guifg=Red
hi diffFile       term=bold   cterm=bold  ctermfg=4   guifg=Blue
hi diffIndexLine              cterm=bold  ctermfg=5   guifg=Magenta
hi diffLine                               ctermfg=6   guifg=Cyan

" call matchadd('Conceal', '\[\ \]', 0, 11, {'conceal': ''})
" call matchadd('Conceal', '\[X\]', 0, 12, {'conceal': ''})
" call matchadd('Conceal', '\[x\]', 0, 13, {'conceal': ''})
" hi Conceal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE

hi FoldColumn term=standout   ctermfg=4   ctermbg=253   guifg=DarkBlue guibg=Grey
hi Folded     term=standout   ctermfg=4   ctermbg=253   guifg=DarkBlue guibg=LightGrey

hi SignColumn term=standout   ctermfg=4   ctermbg=254   guifg=DarkBlue guibg=Grey

hi SignifySignAdd     cterm=bold  ctermfg=2   ctermbg=254
hi SignifySignChange  cterm=bold  ctermfg=130 ctermbg=254
hi SignifySignDelete  cterm=bold  ctermfg=1   ctermbg=254

hi GitGutterAdd       cterm=bold  ctermfg=2   ctermbg=254   guifg=#009900
hi GitGutterChange    cterm=bold  ctermfg=130 ctermbg=254   guifg=#bbbb00
hi GitGutterDelete    cterm=bold  ctermfg=1   ctermbg=254   guifg=#ff2222

" requirements.txt
hi def link requirementsPackageName Structure
hi def link requirementsVersionSpecifiers Operator

