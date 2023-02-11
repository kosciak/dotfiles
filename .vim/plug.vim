" .vimrc
" .vim/plug.vim
" .vim/plugins.vim
"
" Author: Wojciech 'KosciaK' Pietrzok
"
" ----------------------------------------------------------------------
"  Plugins installation
" ----------------------------------------------------------------------

" Auto install Vim-plug manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" By default .vim/plugged/ is used as plugins install directory
call plug#begin()

  " Vim Plug itself, for documentation to work
    Plug 'junegunn/vim-plug'

  " General settings
    Plug 'tpope/vim-sensible'         " Sensible default settings
    Plug 'tpope/vim-unimpaired'       " Complementary pairs of mappings

  " Filesystem
    Plug 'duggiefresh/vim-easydir'    " Create directories on :write

  " Editing
    Plug 'tpope/vim-repeat'           " Repeat supported plugin maps (like vim-surround)
    Plug 'tpope/vim-surround'         " Quoting / parenthesizing made simple
    Plug 'tpope/vim-commentary'       " Commenting stuff out
    Plug 'tpope/vim-speeddating'      " Increment / decrement dates

    Plug 'godlygeek/tabular'          " Tabularize text NOTE: Load *before* vim-markdown!
    Plug 'dhruvasagar/vim-table-mode' " Table creator and formatter

    Plug 'dkarter/bullets.vim'        " Bullet lists automation
    " Plug 'lervag/lists.vim'

    Plug 'AndrewRadev/sideways.vim'   " Move items to the righ or left
    Plug 'machakann/vim-swap'         " Arguments swapping

    Plug 'alvan/vim-closetag'         " Auto close HTML tags

    " Plug 'rhysd/clever-f.vim'         " Better f, F, t, T repeating

  " Language packs - syntax, indentation, highlighting
    let g:polyglot_disabled = ['markdown']  " NOTE: MUST be declared BEFORE loading plugin!
    " let g:polyglot_disabled = ['autoindent']  " Disable indentation heuristics
    Plug 'sheerun/vim-polyglot'           " Collection of language packs
      " Provided by polyglot (install separately if you need help file):
      Plug 'plasticboy/vim-markdown'      " Updated version
      " Plug 'pangloss/vim-javascript'
      " Plug 'vim-python/python-syntax'
      " Plug 'Vimjas/vim-python-pep8-indent'

    Plug 'chikamichi/mediawiki.vim'

    Plug 'raimon49/requirements.txt.vim'  " Syntax for requirements.txt files

    Plug 'tmhedberg/simpylfold'           " Python folding rules
    Plug 'jeetsukumaran/vim-pythonsense'  " Python text objects and motions

    Plug 'michaeljsmith/vim-indent-object'  " Indentation oriented text objects
    Plug 'wellle/targets.vim'             " Improved text objects

    " Plug 'SidOfc/mkdx'                  " Feature rich if not too complicated
    " Plug 'vim-pandoc/vim-pandoc'
    " Plug 'vim-pandoc/vim-pandoc-syntax'

    " Plug 'groenewege/vim-less'          " TODO: Check if needed

  " Buffers / Windows / Tabs
    Plug 'jlanzarotta/bufexplorer'    " Buffer explorer / switcher

    Plug 'ton/vim-bufsurf'            " Jump to previous / next file

    Plug 'tyru/capture.vim'           " Show Ex command in a buffer

    " Plug 'sedm0784/vim-resize-mode'   " Window Resize mode

  " Registers
    Plug 'junegunn/vim-peekaboo'      " Show register's contents in sidebar

  " Search and Find
    Plug 'romainl/vim-cool'           " Auto disable search highlighting

    Plug 'ctrlpvim/ctrlp.vim'         " Full path fuzzy finder
    " Plug 'raghur/fruzzy', { 'do': { -> fruzzy#install() } }
    " Plug 'FelikZ/ctrlp-py-matcher'
    " Plug 'mattn/ctrlp-matchfuzzy'
    " Plug 'nixprime/cpsm', { 'do': './install.sh' }

    " Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

    " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " Plug 'junegunn/fzf.vim'

    Plug 'dyng/ctrlsf.vim'            " TODO: Configure!

    " Plug 'lokikl/vim-ctrlp-ag'        " TODO: Check and configure
    " Plug 'jremmen/vim-ripgrep'        " TODO: Check if needed

  " Files
    Plug 'scrooloose/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " Plug 'Xuyuanp/nerdtree-git-plugin'

    " Plug 'lambdalisue/fern.vim'
    " Plug 'lambdalisue/nerdfont.vim'
    " Plug 'lambdalisue/fern-renderer-nerdfont.vim'
    " Plug 'lambdalisue/glyph-palette.vim'
    " Plug 'lambdalisue/fern-git-status.vim'
    " Plug 'lambdalisue/fern-hijack.vim'
    " Plug 'yuki-yano/fern-preview.vim'
    " Plug 'KosukeMizuno/ctrlp-fern-action.vim'
    " let g:fern#renderer = "nerdfont"

    " Plug 'obaland/vfiler.vim'
    " Plug 'obaland/vfiler-column-devicons'

  " Tags
    Plug 'majutsushi/tagbar'          " Tags tree explorer

  " Completion
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --ts-completer' }

    Plug 'ervandew/supertab'          " Improved Tab completion

  " Color previews
    Plug 'ap/vim-css-color'

  " Version control
    Plug 'tpope/vim-fugitive'         " Git integration
    Plug 'tpope/vim-rhubarb'          " :GBrowse GitHub support
    Plug 'junegunn/gv.vim'            " Git commit browser
    Plug 'mhinz/vim-signify'          " Show changed/added/deleted lines

  " Wiki, notes taking, journaling
    Plug 'lervag/wiki.vim'            " Wiki engine

    Plug 'mtth/scratch.vim'           " Temporary scratch buffer

  " Distraction free mode
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'

  " Icons
    " NOTE: Must be loaded as the last one
    Plug 'ryanoasis/vim-devicons'     " Enable NerdFonts support

" End of plugins list
call plug#end()

