set runtimepath+=/home/tristan/.nvim/repos/github.com/Shougo/dein.vim

if dein#load_state('/home/tristan/.nvim')
    call dein#begin('/home/tristan/.nvim')
    call dein#add('/home/tristan/.nvim/repos/github.com/Shougo/dein.vim')

    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')

    call dein#add('honza/vim-snippets')

    call dein#add('Shougo/deoplete.nvim')
    call dein#add('zchee/deoplete-jedi')
    call dein#add('Rip-Rip/clang_complete')
    call dein#add('Shougo/neco-vim')

    call dein#add('airblade/vim-gitgutter')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets')
    call dein#add('morhetz/gruvbox')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-surround')
    call dein#add('sjl/gundo.vim')
    call dein#add('majutsushi/tagbar')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    call dein#add('vim-syntastic/syntastic')
    call dein#add('kien/rainbow_parentheses.vim')
    call dein#add('easymotion/vim-easymotion')
    call dein#add('mhinz/vim-startify')

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
