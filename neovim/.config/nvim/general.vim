set number
set linebreak
set showbreak=++
set foldmethod=marker
set showmatch
set ruler

set cursorline
set cursorcolumn
" Only on current windows
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn

set backspace=indent,eol,start
set autoread 
set showcmd


set completeopt+=menuone

" Selected characters/lines in visual mode
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

set wildmenu
set wildmode=longest,list,full

set modeline

set mouse=a

set hidden

"" tabs
set expandtab   " Use spaces instead of tabs
set autoindent
set shiftwidth=4    " Number of auto-indent spaces
set smartindent
set smarttab 
set softtabstop=4
set tabstop=8
set shiftround 

set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
set list

set laststatus=2
set noshowmode

"Other undo opts
set undolevels=1000
set undoreload=10000

set incsearch
set ignorecase
set smartcase

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
