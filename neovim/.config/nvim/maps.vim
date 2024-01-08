"Toggle relative/absolute line numbers
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

au FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()

let g:AutoPairsMapCR = 0

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



" completion with tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
inoremap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"

cmap w!! %!sudo tee > /dev/null %

nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S

let g:UltiSnipsExpandTrigger = '<c-e>'
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

nnoremap <F2> :GundoToggle<CR>
nnoremap <F4> :call NumberToggle()<cr>
nnoremap <silent> <F5> :call StripTrailingWhitespace()<CR>
nnoremap <F6> :Tagbar<CR>

map <silent> <F10> "<Esc>:silent setlocal spell! spelllang=en<CR>"
map <silent> <F11> "<Esc>:silent setlocal spell! spelllang=fr<CR>"

au FileType haskell nnoremap <buffer> <F7> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F8> :HdevtoolsClear<CR>
