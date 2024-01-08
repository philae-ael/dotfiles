vim.opt.signcolumn = 'yes'

local lsp = require('lsp-zero')
lsp.preset('recommended')
require("lsp-inlayhints").setup({
  inlay_hints = {
    highlight = "Comment",
  },
})

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'lua_ls',
  'texlab'
})



lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

lsp.configure('cssls', {
  settings = {
    scss = {
      lint = {
        unknownAtRules = 'ignore'
      }
    }
  }
})

lsp.configure('gopls', {
  settings = {
    gopls = {
      gofumpt = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

lsp.configure('texlab', {
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = {
          "-xelatex",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
          "%f"
        },
        forwardSearchAfter = true,
        onSave = true,
      },
      chktex = { onOpenAndSave = true },
      forwardSearch = {
        executable = 'sioyek',
        args = {
          '--reuse-window',
          '--inverse-search',
          [[nvim-texlabconfig -file %1 -line %2]],
          '--forward-search-file', '%f',
          '--forward-search-line', '%l', '%p'
        },
      },
    },
  },
})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- local ELLIPSIS_CHAR = '…'
-- local MAX_LABEL_WIDTH = 30
-- local MIN_LABEL_WIDTH = 15

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
--   formatting = {
--     format = function(_, vim_item)
--       local label = vim_item.abbr
--       local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
--       if truncated_label ~= label then
--         vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
--       elseif string.len(label) < MIN_LABEL_WIDTH then
--         local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
--         vim_item.abbr = label .. padding
--       end
--       return vim_item
--     end,
--   },
})


local builtin = require('telescope.builtin')

lsp.on_attach(function(client, bufnr)
  local opts = function(desc) return { desc = desc, buffer = bufnr, remap = false } end

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts("Show diagnostics in a floating window"))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover documentation"))
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Goto next diagnostic"))
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Goto previous diagnostic"))
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts("View signature help"))
  vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, opts("View code action"))

  require("which-key").register { ["<leader>v"] = { name = "LSP bindings" } }
  vim.keymap.set("n", "<leader>vs", builtin.lsp_workspace_symbols, opts("Workspace symbol"))
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts("Open diagnostic"))
  vim.keymap.set("n", "<leader>vr", builtin.lsp_references, opts("View references"))
  vim.keymap.set("n", "<leader>vi", builtin.lsp_implementations, opts("View implementations"))
  vim.keymap.set("n", "<leader>vn", vim.lsp.buf.rename, opts("Rename symbol"))
  vim.keymap.set("n", "<leader>vf", function() vim.lsp.buf.format({ async = true }) end, opts("Format file"))
  vim.keymap.set("n", "<leader>vl", builtin.loclist, opts("open loclist"))

  require("lsp-inlayhints").on_attach(client, bufnr)
  vim.keymap.set("n", "<leader>vh", require('lsp-inlayhints').toggle, {desc="Toggle inlay hints"})

end)

lsp.nvim_workspace()

lsp.skip_server_setup({ 'rust_analyser' })

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

local clangd_lsp = lsp.build_options('clangd',
  {
    cmd = { "clangd", "--background-index", "--completion-style=detailed" }
  }
)

require("lspconfig").clangd.setup(clangd_lsp)


local rust_tools = require("rust-tools")

local rt_lsp = lsp.build_options('rust_analyser', {
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
        extraArgs = { "--all", "--", "-W", "clippy::all" },
      },
    },
  },
})

rust_tools.setup({
  server = rt_lsp,
  tools = {
    inlay_hints = {
      auto = false
    }
  }
})
