call plug#begin('~/.plugged')

Plug 'junegunn/vim-plug'

Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair
Plug 'kien/rainbow_parentheses.vim' " Change parentheses colors
Plug 'airblade/vim-gitgutter' " Print diff info in the gutter (1st left column)
Plug 'liuchengxu/vim-which-key'
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-surround' " Quoting/parenthezing
Plug 'ludovicchabant/vim-gutentags'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clangd-completer --cs-completer --go-completer --java-completer --ts-completer --rust-completer
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

Plug 'neomake/neomake'

Plug 'junegunn/vim-easy-align'

call plug#end()
