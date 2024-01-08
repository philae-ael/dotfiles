let g:ale_linters = { 
\   'cpp': ['clangcheck', 'clangtidy'] 
\}

let g:ale_cpp_clangtidy_checks = ['-*', 'clang-analyzer-*', 
            \'performance-*', 'readability-*', 'boost-*',
            \'bugprone-*']
let g:ale_c_clangtidy_checks = ['-*', 'clang-analyzer-*', 
            \'performance-*', 'readability-*', 'bugprone-*']

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
