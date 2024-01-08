let g:ycm_autoclose_preview_window_after_insertion = 1

let which_key_map_localleader.y = {
            \ "namea": "+ycm",
            \ "i": "goto-include",
            \ "s": "goto-declaration",
            \ "d": "goto-definition",
            \ "g": "goto",
            \ "t": "get-type",
            \ "r": "rename",
            \ "f": "format",
            \ }

function Refactor_rename()
    execute "YcmCompleter RefactorName " . input('New name ?')
endfunction

nn <silent> <localleader>yi :YcmCompleter GoToInclude<CR>
nn <silent> <localleader>ys :YcmCompleter GoToDeclaration<CR>
nn <silent> <localleader>yd :YcmCompleter GoToDefinition<CR>
nn <silent> <localleader>yg :YcmCompleter GoTo<CR>
nn <silent> <localleader>yt :YcmCompleter GetType<CR>
nn <silent> <localleader>yr :call Refactor_rename()<CR>
nn <silent> <localleader>yf :YcmCompleter Format<CR>

let g:ycm_language_server =
\ [
\   {
\     'name': 'rust',
\     'cmdline': ['rust-analyzer'],
\     'filetypes': ['rust'],
\     'project_root_files': ['Cargo.toml']
\   }
\ ]

