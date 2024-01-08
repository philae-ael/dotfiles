nn <Plug>(fzffile) :Files<CR>
nn <Plug>(fzfbuffers) :Buffers<CR>
nn <Plug>(fzftags) :Tags<CR>

map <c-P> <Plug>(fzffile)
map <c-T> <Plug>(fzftags)
map <c-B> <Plug>(fzfbuffers)

if has('nvim')
else
    let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'Comment' } }
endif
