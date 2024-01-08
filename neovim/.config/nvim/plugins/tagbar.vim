" TagBar
let g:tagbar_type_haskell = {
            \ 'ctagsbin'  : 'hasktags',
            \ 'ctagsargs' : '-x -c -o-',
            \ 'kinds'     : [
            \  'm:modules:0:1',
            \  'd:data: 0:1',
            \  'd_gadt: data gadt:0:1',
            \  't:type names:0:1',
            \  'nt:new types:0:1',
            \  'c:classes:0:1',
            \  'cons:constructors:1:1',
            \  'c_gadt:constructor gadt:1:1',
            \  'c_a:constructor accessors:1:1',
            \  'ft:function types:1:1',
            \  'fi:function implementations:0:1',
            \  'o:others:0:1'
            \ ],
            \ 'sro'        : '.',
            \ 'kind2scope' : {
            \ 'm' : 'module',
            \ 'c' : 'class',
            \ 'd' : 'data',
            \ 't' : 'type'
            \ },
            \ 'scope2kind' : {
            \ 'module' : 'm',
            \ 'class'  : 'c',
            \ 'data'   : 'd',
            \ 'type'   : 't'
            \ }
            \ }
let g:tagbar_type_markdown = {
            \ 'ctagstype' : 'markdown',
            \ 'kinds' : [
            \ 'h:Heading_L1',
            \ 'i:Heading_L2',
            \ 'k:Heading_L3'
            \ ]
            \ }
let g:tagbar_type_make = {
            \ 'kinds':[
            \ 'm:macros',
            \ 't:targets'
            \ ]
            \}

let g:tagbar_show_linenumbers = 2
autocmd VimEnter * nested :call tagbar#autoopen(1) " auto open tagbar
