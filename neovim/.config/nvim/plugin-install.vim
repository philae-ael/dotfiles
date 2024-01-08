set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')
    call dein#add('~/.cache/dein')

    call dein#add('Shougo/deoplete.nvim') " Completion framework
    call dein#add('zchee/deoplete-jedi') " Python deoplete provider
    call dein#add('Shougo/neco-vim')

    call dein#add('airblade/vim-gitgutter') " Print diff info in the gutter (1st left column)
    call dein#add('jiangmiao/auto-pairs') " Insert or delete brackets, parens, quotes in pair

    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets')

    call dein#add('morhetz/gruvbox')
    call dein#add('kien/rainbow_parentheses.vim') " Change parentheses colors
    call dein#add('Shougo/vimproc.vim', {'build' : 'make'}) " Used by others plugins
    call dein#add('tpope/vim-surround') " Quoting/parenthezing

    call dein#add('vim-airline/vim-airline') " Status bar
    call dein#add('vim-airline/vim-airline-themes')

    call dein#add('dense-analysis/ale') " Lint engine

    call dein#add('ctrlpvim/ctrlp.vim') " Fast Fast


    call dein#add('sheerun/vim-polyglot') " Pack of langs (syntax, indent, ftplugin...)

    call dein#add('godlygeek/tabular') " Fast align 

    call dein#add('rust-lang/rust.vim')
    call dein#add('vim-syntastic/syntastic')

    call dein#add('lervag/vimtex')
    call dein#add('KeitaNakamura/tex-conceal.vim')

    call dein#add('justinmk/vim-sneak')
    call dein#add('kshenoy/vim-signature')
    call dein#end()
    call dein#save_state()
end

filetype plugin indent on
syntax enable
