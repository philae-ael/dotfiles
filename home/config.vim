set linebreak
set showbreak=++
set foldmethod=marker
set showmatch
set number

set showcmd

set completeopt+=menu,menuone,preview

" selected characters/lines in visual mode
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

set wildmode=longest,list,full

set modeline
set mouse=a

set path+=**

"" tabs
set expandtab
set autoindent
set shiftwidth=2
set smartindent
set softtabstop=2
set tabstop=8
set shiftround

set listchars=tab:▸\ ,trail:·,multispace:\|\ \ \ ,extends:❯,precedes:❮,nbsp:×
set list
set conceallevel=1

set ignorecase
set smartcase

set timeoutlen=300
set updatetime=800

set signcolumn=yes

au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn

"" remove trailing spaces
function! StripTrailingWhitespace()
    " preparation: save last search, and cursor position.
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

nnoremap <silent> <f5> :call StripTrailingWhitespace()<cr>

au vimenter * RainbowParenthesesToggle
au syntax   * RainbowParenthesesLoadRound
au syntax   * RainbowParenthesesLoadSquare
au syntax   * RainbowParenthesesLoadBraces

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

vmap < <gv
vmap > >gv

let g:airline_powerline_fonts = 1

lua <<EOF
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require'lspkind'
local luasnip = require'luasnip'

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({})
    },
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
    mapping = {
        ['<c-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<c-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<c-y>'] = cmp.config.disable,
        ['<c-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),}),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable(1) then
                luasnip.expand_or_jump(1)
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        -- accept currently selected item. if none selected, `select` first item.
        -- set `select` to `false` to only confirm explicitly selected items.
        ['<cr>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip', option = { use_show_condition = false } },
        { name = 'path' },

    }, {
    { name = 'buffer' },
    })
})

vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})


-- use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
        }
    })

-- use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
    { name = 'path' }
    }, {
    { name = 'cmdline' }
    })
})

local saga = require 'lspsaga'
saga.setup { -- defaults ...
  finder_action_keys = {
      open = {"<cr>", "o"},
      vsplit = "s",
      split = "i",
      quit = {"q", "<esc>", "<c-c>"},
      scroll_down = "<c-f>",
      scroll_up = "<c-b>",
      },
  code_action_keys = {
      quit = {"q", "<esc>", "<c-c>"},
      exec = "<cr>",
      },
  rename_action_keys = {
      quit = {"q", "<esc>", "<c-c>"},
      exec = "<cr>",
      },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  }


local wk = require("which-key")

local types = require("luasnip.util.types")

require'luasnip'.config.setup({
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = {{"●", "GruvboxOrange"}}
      }
    },
    [types.insertNode] = {
      active = {
        virt_text = {{"●", "GruvboxBlue"}}
      }
    }
  },
})

-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md to add more servers
local nvim_lsp = require('lspconfig')


local function on_attach_generic(clent, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- mappings.
    local opts = { noremap=true, silent=true }

    -- see `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', '<leader><shift>n', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    buf_set_keymap('n', '<leader>n',        '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
    buf_set_keymap('n', '<leader>s',        '<cmd>Lspsaga signature_help<cr>',         opts)
    buf_set_keymap('n', '<leader>l',        '<cmd>Lspsaga show_line_diagnostics<cr>',  opts)
    buf_set_keymap('n', '<leader>r',        '<cmd>Lspsaga rename<cr>',                 opts)
    buf_set_keymap('n', '<leader>p',        '<cmd>Lspsaga preview_definition<cr>',     opts)
    buf_set_keymap('n', '<leader>d',        '<cmd>Lspsaga hover_doc<cr>',              opts)
    buf_set_keymap('n', 'K',                '<cmd>Lspsaga hover_doc<cr>',              opts)
    buf_set_keymap('n', '<leader>f',        '<cmd>Lspsaga lsp_finder<cr>',             opts)
    buf_set_keymap('n', '<leader>i',        '<cmd>Lspsaga implement<cr>',              opts)
    buf_set_keymap('n', '<leader>=',        '<cmd>lua vim.lsp.buf.formatting()<cr>',   opts)
    buf_set_keymap('n', '<leader>a',        '<cmd>Lspsaga code_action<cr>',            opts)
    buf_set_keymap('v', '<leader>a',        '<cmd><c-u>Lspsaga range_code_action<cr>', opts)


    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)



    wk.register({
    d = { "documentation" },
    f = { "finder" },
    r = { "rename" },
    s = { "signature help" },
    n = { "diagnotic next" },
    p = { "preview definition" },
    l = { "show line diagnostics" },
    a = {"code action"},
    i = {"implementation"},
    ["="] = {"formatting"},
    }, { prefix = "<leader>" })
end



-- setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.hls.setup           { capabilities = capabilities, on_attach = on_attach_generic }
nvim_lsp.vimls.setup         { capabilities = capabilities, on_attach = on_attach_generic }
nvim_lsp.ccls.setup          { capabilities = capabilities, on_attach = on_attach_generic }
nvim_lsp.cmake.setup         { capabilities = capabilities, on_attach = on_attach_generic }
nvim_lsp.rust_analyzer.setup { capabilities = capabilities, on_attach = on_attach_generic }
nvim_lsp.rnix.setup          { capabilities = capabilities, on_attach = on_attach_generic }

wk.register({
h = {
    name = "git",
    s = { "stage" },
    p = { "preview" },
    u = { "undo" },
    }
}, { prefix = "<leader>" })

EOF
set termguicolors
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="medium"
colorscheme gruvbox
hi normal ctermfg=223 ctermbg=none guifg=#ebdbb2 guibg=none
