nnoremap <silent> <leader> :WhichKey mapleader<CR>
nnoremap <silent> <localleader> :WhichKey maplocalleader<CR>

call which_key#register(mapleader, 'g:which_key_map_leader')
call which_key#register(maplocalleader, 'g:which_key_map_localleader')

let g:which_key_map_leader =  {}
let g:which_key_map_localleader =  {}

set timeoutlen=500
