g:necoghc_use_stack=1
g:necoghc_enable_detailed_browse=1

let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
