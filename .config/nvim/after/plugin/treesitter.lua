local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
vim.filetype.add({ extension = { wgsl = "wgsl" } })

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "wgsl" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
        ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = { query = "@function.outer", desc = "Next method start" },
        ["]]"] = { query = "@class.outer", desc = "Next class start" },
        ["]o"] = { query = { "@loop.inner", "@loop.outer" }, desc = "Next loop" },
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]M"] = { query = "@function.outer", desc = "Next method end" },
        ["]["] = { query = "@class.outer", desc = "Next class end" },
      },
      goto_previous_start = {
        ["[m"] = { query = "@function.outer", desc = "Previous method start" },
        ["[["] = { query = "@class.outer", desc = "Previous class start" },
      },
      goto_previous_end = {
        ["[M"] = { query = "@function.outer", desc = "Previous method end" },
        ["[]"] = { query = "@class.outer", desc = "Previous class end" },
      },
      goto_next = {
        ["]c"] = { query = "@conditional.outer", desc = "Next conditional" }
      },
      goto_previous = {
        ["[c"] = { query = "@conditional.outer", desc = "Previous conditional" }
      }
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
}

