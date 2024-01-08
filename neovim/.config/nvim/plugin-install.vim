set runtimepath+=/home/tristan/.nvim/repos/github.com/Shougo/dein.vim

if dein#load_state('/home/tristan/.nvim')
    call dein#begin('/home/tristan/.nvim')
    call dein#add('/home/tristan/.nvim/repos/github.com/Shougo/dein.vim')

    call dein#add('vimlab/split-term.vim')

    call dein#add('dpelle/vim-Grammalecte')

    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/neoinclude.vim')
    call dein#add('zchee/deoplete-jedi')
    call dein#add('zchee/deoplete-clang')
    call dein#add('Shougo/neco-vim')

    call dein#add('airblade/vim-gitgutter')
    call dein#add('jiangmiao/auto-pairs')

    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets')

    call dein#add('morhetz/gruvbox')
    call dein#add('tpope/vim-dispatch')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-surround')
    call dein#add('sjl/gundo.vim')
    call dein#add('majutsushi/tagbar')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    call dein#add('vim-syntastic/syntastic')

    call dein#add('Vimjas/vim-python-pep8-indent')
    call dein#add('ctrlpvim/ctrlp.vim')

    call dein#add('lervag/vimtex')

    call dein#add('kien/rainbow_parentheses.vim')
    call dein#add('easymotion/vim-easymotion')
    call dein#add('mhinz/vim-startify')
    call dein#add('tpope/vim-commentary')
    call dein#add('posva/vim-vue')
    call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

    call dein#add('godlygeek/tabular')

    call dein#add('neovimhaskell/haskell-vim')
    call dein#add('eagletmt/neco-ghc')
    call dein#add('eagletmt/ghcmod-vim')

    call dein#end()
    call dein#save_state()
else
    call dein#clear_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
    call dein#install()
endif
