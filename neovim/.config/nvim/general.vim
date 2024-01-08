let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
let maplocalleader=","

set number      " Show line numbers
set linebreak   " Break lines at word (requires Wrap lines)
set showbreak=++        " Wrap-broken line prefix
set colorcolumn=90
set foldmethod=marker
set showmatch	" Highlight matching brace
set ruler	" Show row and column ruler informationa
set cursorline " Highlight current line
set cursorcolumn " Highlight current line
set backspace=indent,eol,start
set autoread " reload files when changed on disk, i.e. via `git checkout`
set showcmd                 " Show partial commands in status line and

" Selected characters/lines in visual mode
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

set wildmenu    " show a navigable menu for tab completion
set wildmode=longest,list,full

" Allow modelines
set modeline
set modelines=2

set mouse=a

"" tabs
set expandtab	" Use spaces instead of tabs
set autoindent
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab
set tabstop=8 " because of hlint
set shiftround  "Round indent to nearest shiftwidth multiple

set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
set list " Enable by default

set laststatus=2
set noshowmode

"Other undo opts
set undolevels=1000         " Maximum number of changes that can be undone
set undoreload=10000        " Maximum number lines to save for undo on buffer reload  "


set incsearch
set ignorecase
set smartcase
set hlsearch

au BufRead,BufNewFile make.config setfiletype make
au BufRead,BufNewFile *.asm set filetype=nasm

" Tex files are latex
let g:tex_flavor='latex'
