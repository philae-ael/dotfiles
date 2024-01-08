au BufRead,BufNewFile make.config setfiletype make
au BufRead,BufNewFile *.asm set filetype=nasm

au FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()



let g:which_key_map_leader.f = {
    \ 'name'  : '+filetype-specific'
    \ }


augroup fileType_vim
    au!

    set iskeyword+=:
    function FileType_vim()
        nnoremap <buffer><leader>fs :source %<CR>
        let g:which_key_map_leader.f.s = 'source file'

        nnoremap <buffer><leader>fh :h <C-R><C-W><CR>
        let g:which_key_map_leader.f.h = 'help'
    endfunction
    au FileType vim call FileType_vim()
augroup end

