" deoplete 
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib64/clang'
let g:deoplete#auto_complete_start_length = 4
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

call deoplete#custom#var('omni', 'input_patterns', {
          \ 'tex': g:vimtex#re#deoplete
          \})
