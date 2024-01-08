let g:tex_flavor = 'latex'
let g:vimtex_view_method='zathura'
let g:vimtex_compiler_latexmk = {"build_dir":'./build'}
let g:vimtex_compiler_progname = 'nvr'

augroup vimtex_maps
    au!
    autocmd FileType tex nnoremap <silent> <2-LeftMouse> :VimtexView<CR>
    function Vimtex_maps()
        let g:which_key_map_localleader.l = {
                    \ "name" : "+vimtex",
                    \ "v": "view",
                    \ "l": "compile",
                    \ "L": "compile-selected",
                    \ "c": "clean",
                    \ "C": "clean-full",
                    \ "t": "toc-open",
                    \ "T": "toc-toggle",
                    \ "i": "info",
                    \ "I": "info-full"
                    \ }
    endfunction
    au Filetype tex call Vimtex_maps()
augroup end

set conceallevel=2
let g:tex_conceal="abg"
