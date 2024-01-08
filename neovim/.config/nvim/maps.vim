"Toggle relative/absolute line numbers
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction


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

cmap w!! %!sudo tee > /dev/null %

nnoremap <F4> :call NumberToggle()<cr>
nnoremap <silent> <F5> :call StripTrailingWhitespace()<CR>

let g:which_key_map_leader['b'] = {
    \ 'name': '+buffer',
    \ 'v': [':vne', 'new-buffer-split-vertical'],
    \ 'h': [':new', 'new--split-horizontal'],
    \ 'n': [':bn', 'next-buffer'],
    \ 'p': [':bp', 'previous-buffer'],
    \ 'd': [':bd', 'delete-buffer'],
    \ 'l': [':ls', 'list-buffer'],
    \ 'f': [':Buffers', 'list-buffer'],
    \ }

let g:which_key_map_leader['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ 'f' : ['Windows'    , 'fzf-window']            ,
      \ }


