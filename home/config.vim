
set linebreak
set showbreak=++
set foldmethod=marker
set showmatch
set ruler
set number

set cursorline
set cursorcolumn
" Only on current windows
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn

set backspace=indent,eol,start
set autoread
set showcmd

set completeopt+=menu,menuone,noselect

" Selected characters/lines in visual mode
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

set wildmenu
set wildmode=longest,list,full

set modeline

set mouse=a

set hidden

"" tabs
set expandtab   " Use spaces instead of tabs
set autoindent
set shiftwidth=4    " Number of auto-indent spaces
set smartindent
set smarttab
set softtabstop=4
set tabstop=8
set shiftround

set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
set list

set laststatus=2
set noshowmode

"Other undo opts
set undolevels=1000
set undoreload=10000

set incsearch
set ignorecase
set smartcase

set timeoutlen=300
set updatetime=100

"Toggle relative/absolute line numbers
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction


"" remove trailing spaces
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search
    "history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction


cmap w!! %!sudo tee > /dev/null %

nnoremap <F4> :call NumberToggle()<cr>
nnoremap <silent> <F5> :call StripTrailingWhitespace()<CR>

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:airline_powerline_fonts = 1

let g:lsp_diagnostics_float_cursor = 1

" Expand or jump
imap <expr> <C-e>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-e>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

set termguicolors
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="medium"
colorscheme gruvbox

nnoremap <silent><leader>a :Lspsaga code_action<CR>
vnoremap <silent><leader>a :<C-U>Lspsaga range_code_action<CR>

nnoremap <silent><leader>l :Lspsaga show_line_diagnostics<CR>
nnoremap <silent><leader>n :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent><leader>p :Lspsaga diagnostic_jump_prev<CR>


nnoremap <silent><leader>f :Lspsaga lsp_finder<CR>

nnoremap <silent><leader>d :Lspsaga hover_doc<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

nnoremap <silent><leader>s :Lspsaga signature_help<CR>
nnoremap <silent><leader>r :Lspsaga rename<CR>
nnoremap <silent><leader>p :Lspsaga preview_definition<CR>



lua <<EOF
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, 
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),}),
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif vim.fn["vsnip#available"](1) == 1 then
                    feedkey("<Plug>(vsnip-expand-or-jump)", "")
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                end
            end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(
            function()
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                    feedkey("<Plug>(vsnip-jump-prev)", "")
                end
            end, { "i", "s" }),

        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
        }
    })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
    { name = 'path' }
    }, {
    { name = 'cmdline' }
    })
})

local saga = require 'lspsaga'
saga.setup { -- defaults ...
    debug = false,
    use_saga_diagnostic_sign = true,
    -- diagnostic sign
    error_sign = "",
    warn_sign = "",
    hint_sign = "",
    infor_sign = "",
    diagnostic_header_icon = "   ",
    -- code action title icon
    code_action_icon = " ",
    code_action_prompt = {
        enable = true,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
    },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
      open = {"<CR>", "o"},
      vsplit = "s",
      split = "i",
      quit = "q",
      scroll_down = "<C-f>",
      scroll_up = "<C-b>",
      },
  code_action_keys = {
      quit = "q",
      exec = "<CR>",
      },
  rename_action_keys = {
      quit = "<C-c>",
      exec = "<CR>",
      },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  }


-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md to add more servers 
servers = { "hls" }
local nvim_lsp = require('lspconfig')

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {}
end

local wk = require("which-key")
wk.register({
d = { "Documentation" },
f = { "Finder" },
r = { "Rename" },
s = { "Signature help" },
n = { "Diagnotic next" },
p = { "Preview definition" },
l = { "Show line diagnostics" },
a = {"Code action"},
h = {
    name = "git",
    s = { "Stage" },
    p = { "Preview" },
    u = { "Undo" },
    }
}, { prefix = "<leader>" })
EOF

