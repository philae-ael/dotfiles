let g:ale_linters = { 
\ 'c':   ['clangtidy'],
\ 'cpp': ['clangtidy'],
\ 'haskell': ['hie']
\}

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
