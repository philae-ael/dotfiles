set nocompatible
syntax on

let mapleader=","

" General
set number      " Show line numbers
set linebreak   " Break lines at word (requires Wrap lines)
set showbreak=++        " Wrap-broken line prefix
set colorcolumn=120


function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <F4> :call NumberToggle()<cr>

set foldmethod=marker

set showmatch	" Highlight matching brace
set ruler	" Show row and column ruler informationa
set cursorline " Highlight current line
set cursorcolumn " Highlight current line
set backspace=indent,eol,start
set autoread " reload files when changed on disk, i.e. via `git checkout`

"setup ruler

set ruler                   " Show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
set showcmd                 " Show partial commands in status line and
" Selected characters/lines in visual mode

" Copy to X CLIPBOARD
map <leader>c "xy:call system("xsel -i -b", @x)<CR>
" Paste from X CLIPBOARD
map <leader>p :r!xsel -b<CR>

nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

set wildmenu    " show a navigable menu for tab completion
set wildmode=longest,list,full

"" tabs
set expandtab	" Use spaces instead of tabs
set autoindent
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab
set tabstop=8 " because of hlint
set shiftround                  "Round indent to nearest shiftwidth multiple

"" Toggle whitespace visibility with ,s
nmap <Leader>s :set list!<CR>
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
:set list " Enable by default

"" remove trailing spaces
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search
    "history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

nnoremap <silent> <F5> :call StripTrailingWhitespace()<CR>
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()

au BufRead,BufNewFile make.config setfiletype make
au BufRead,BufNewFile *.asm set filetype=nasm

filetype on
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe' " Auto Completion
Plugin 'scrooloose/syntastic' " Syntax verification
Plugin 'airblade/vim-gitgutter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'SirVer/ultisnips' " Snippet engine
Plugin 'honza/vim-snippets' " more snippets
Plugin 'morhetz/gruvbox' " Colorscheme
Plugin 'lilydjwg/colorizer' " Colorize #625664
Plugin 'tpope/vim-commentary' " comment stuff
Plugin 'tpope/vim-fugitive' " Git integration
Plugin 'tpope/vim-surround' " allow to modify surrounding char: ' <> etc.
Plugin 'sjl/gundo.vim' " Allow to navigate in modification tree
Plugin 'scrooloose/nerdtree' " Navigate in files
Plugin 'Xuyuanp/nerdtree-git-plugin' "Add git support to NERDTree
Plugin 'godlygeek/tabular'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/nextval'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" ES6 js
Plugin 'isRuslan/vim-es6' " ES6 support
" Haskell
Plugin 'dag/vim2hs'
Plugin 'eagletmt/neco-ghc'
" Rust
Plugin 'rust-lang/rust.vim'
call vundle#end()


filetype indent on
syntax enable

cmap w!! %!sudo tee > /dev/null %

set incsearch
set ignorecase
set smartcase
set hlsearch

""" Esthetic
set t_Co=256
set background=dark
colorscheme gruvbox
""" let the terminal's transparent background
hi Normal ctermbg=none

""" Mouse accepted but no when writing
set mouse=a
set mousehide

"""End of words
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator
set iskeyword-=_                    " '_' is an end of word designator
1
"" Plugins conf

" Ctags

let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : 'markdown2ctags',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

"syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Autostart NERDTree if no file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Toogle nerdtree
nnoremap <F3> :NERDTreeToggle<CR>

set completeopt=longest,menuone
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

"inoremap <expr> <Esc>       pumvisible() ? "\<C-y>" : "\<Esc>"

"Gundo
nnoremap <F2> :GundoToggle<CR>

" TagBar

nnoremap <F6> :Tagbar<CR>

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsJumpForwardTrigger = "<C-f>"
let g:UltiSnipsJumpBackwardTrigger = "<C-b>"

let g:ycm_key_list_select_completion = ['<tab>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-tab>', '<C-p>', '<Up>']
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:ycm_auto_trigger = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_rust_src_path = "/usr/src/rust/src/"

"necoghc
let g:necoghc_enable_detailed_browse = 1
let g:haskellmode_completion_ghc = 0

" colorizer
let g:colorizer_maxlines = 1000

autocmd Filetype haskell setlocal omnifunc=necoghc#omnifunc

"Other undo opts
set undolevels=1000         " Maximum number of changes that can be undone
set undoreload=10000        " Maximum number lines to save for undo on buffer reload  "


let g:airline_extensions = ['ycm', 'tagbar', 'syntastic']

""Status line
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.crypt = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
set laststatus=2
set noshowmode
