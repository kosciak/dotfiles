set tabstop=8
set softtabstop=4
set shiftwidth=4
set noshiftround
set expandtab
set smarttab

set autoindent
set nosmartindent

set omnifunc=pythoncomplete#Complete

" Open all folds on start
autocmd Syntax python normal zR 	" Doesn't seem to work in VIM 7.2
set foldlevel=5

highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
