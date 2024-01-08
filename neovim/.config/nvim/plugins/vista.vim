let g:vista_icon_indent = ["▸ ", ""]

let g:vista#renderer#icons = {
            \    'func':        "⨍",
            \    'function':    "⨍",
            \    'functions':   "⨍",
            \    'method':      "⨍",
            \    'subroutine':  "⨍",
            \    'implementation':  "⨍",
            \    'var':         "𝑥",
            \    'variable':    "𝑥",
            \    'variables':   "𝑥",
            \    'const':       "const 𝑥",
            \    'constant':    "const 𝑥",
            \    'package':     "➥ ",
            \    'packages':    "➥ ",
            \    'module':      "➥ ",
            \    'modules':     "➥ ",
            \    'enum':        "∑",
            \    'enumerator':  "∑",
            \    'typedef':     "∑",
            \    'type':        "∑",
            \    'types':       "∑",
            \    'augroup':     "∑",
            \    'class':       "∑",
            \    'struct':      "∑",    
            \    'union':       "∑",
            \    'field':       "∙",
            \    'fields':      "∙",
            \    'member':      "∙",
            \    'property':    "∙",
            \    'macro':       "#",
            \    'macros':      "#",
            \    'map':         "🗺 ",
            \    'target':      "",
            \    'interface':   "",
            \    'typeParameter':   "",
            \    'namespace':   "::",
            \    'default':         ""
            \}

nmap <silent><f2> :Vista!!<CR>
nmap <silent><C-G> :Vista finder<CR>
