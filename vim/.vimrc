set nocompatible

syntax on

let mapleader=","

"" General
set number      " Show line numbers
set linebreak   " Break lines at word (requires Wrap lines)
set showbreak=++        " Wrap-broken line prefix
set colorcolumn=120

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

au! BufWritePost .vimrc source % 

filetype on
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'morhetz/gruvbox'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'Townk/vim-autoclose'
Plugin 'tpope/vim-surround'
Plugin 'sjl/gundo.vim'
Plugin 'isRuslan/vim-es6'
" Haskell
Plugin 'dag/vim2hs'
Plugin 'eagletmt/neco-ghc'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ervandew/supertab'
" Rust 
Plugin 'rust-lang/rust.vim'
" ASM 
Plugin 'shirk/vim-gas'
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
"syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

"Gundo
nnoremap <F2> :GundoToggle<CR>


let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsJumpForwardTrigger = "<C-f>"
let g:UltiSnipsJumpBackwardTrigger = "<C-b>"

let g:ycm_key_list_select_completion = ['tab', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-tab>', '<C-p>', '<Up>']
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:ycm_auto_trigger = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_rust_src_path = "/usr/src/rust/src/"

"necoghc
let g:necoghc_enable_detailed_browse = 1
let g:haskellmode_completion_ghc = 0

autocmd Filetype haskell setlocal omnifunc=necoghc#omnifunc

"Other undo opts
set undolevels=1000         " Maximum number of changes that can be undone
set undoreload=10000        " Maximum number lines to save for undo on buffer reload  "

""Status line

set laststatus=2

" Broken down into easily includeable segments
set statusline=%<%f\                     " Filename
set statusline+=%w%h%m%r                 " Options
set statusline+=%{fugitive#statusline()} " Git Hotness
set statusline+=%#warningmsg# "Syntastic
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=\ [%{&ff}/%Y]            " Filetype
set statusline+=\ [%{getcwd()}]          " Current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
