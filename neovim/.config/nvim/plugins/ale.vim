let g:ale_linters = { 
\   'cpp': ['clangcheck', 'clangtidy'] 
\}

let g:ale_cpp_clangtidy_checks = ['-*', 
            \'clang-analyzer-*', 
            \'performance-*', 
            \'readability-*', '-readability-braces-around-statements',
            \'boost-*',
            \'bugprone-*']

let g:ale_c_clangtidy_checks = ['-*', 
            \'clang-analyzer-*', 
            \'performance-*', 
            \'readability-*', '-readability-braces-around-statements',
            \'bugprone-*']

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
