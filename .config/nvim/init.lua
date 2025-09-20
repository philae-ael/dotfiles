vim.set_opts = function(vim_opts)
  for scope, opts in pairs(vim_opts) do
    for k, v in pairs(opts) do
      vim[scope][k] = v
    end
  end
end

vim.keymap.set_bulk = function(bopts)
  for _, key in ipairs(bopts.keys) do
    local opts = bopts.opts or {}
    for k, v in pairs(key) do
      if type(k) ~= 'number' and k ~= 'mode' then
        opts[k] = v
      end
      if k == 3 then
        print 'Warning: numeric key in keymap definition, you do not need that and you should inline the options'
      end
    end

    vim.keymap.set(key.mode or 'n', key[1], key[2], opts)
  end
end

vim.set_opts {
  g = {
    mapleader = ' ',
    maplocalleader = ' ',
  },
  opt = {
    updatetime = 250,
    timeoutlen = 300,

    pumblend = 10, -- Make builtin completion menus slightly transparent
    pumheight = 10, -- Make popup menu smaller
    winblend = 10, -- Make floating windows slightly transparent
    winborder = 'rounded',
    list = true,
    tabstop = 2,
    expandtab = true,
    softtabstop = 2,
    shiftwidth = 2,
    swapfile = false,
    makeprg = 'make -j20',
    concealcursor = '',
    signcolumn = 'yes',
  },
}

vim.opt.listchars:append {
  tab = '▎ ',
  extends = '…',
  precedes = '…',
  nbsp = '␣',
  conceal = '.',
}
vim.opt.fillchars:append { vert = '┃', horiz = '━', horizdown = '┳', horizup = '┻', verthoriz = '╋', vertleft = '┫', vertright = '┣' }
vim.filetype.add { extension = { frag = 'glsl', vert = 'glsl', typst = 'typst', asm = 'nasm', slang = 'shaderslang' } }



-- stylua: ignore
vim.keymap.set_bulk{
  keys = {
    { mode = { 'n', 'v' }, '<leader>y', [["+y]], desc = '[Y]ank into system clipboard' },
    { mode = { 'n', 'v' }, '<leader>p', [["+p]], desc = '[P]aste from system clipboard' },
    { mode = 'n', '<leader>P', [["+P]], desc = '[P]aste from system clipboard' },
    { '<leader>Y', [["+Y]], desc = '[Y]ank until the end of line into system clipboard' },
    { mode = { 'n', 'v' }, '<leader>d', [["_d]], desc = '[D]elete without modifying registers' },
    { mode = { 'v' }, '<leader>zm', ":'<'>%!zm<cr>", desc = 'Filter selection through [ZM]' },
    { '<leader>zm', ':%!zm<cr>', desc = 'Filter buffer through [ZM]' },
    { mode = { 'n', 'v' }, '<Space>', '<Nop>',  silent = true  },
    { 'k', "v:count == 0 ? 'gk' : 'k'",  expr = true, silent = true  },
    { 'j', "v:count == 0 ? 'gj' : 'j'",  expr = true, silent = true  },
    { 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"',  expr = true, replace_keycodes = false, desc = 'Visually select changed text'  },
    { ']e', function() vim.diagnostic.jump { count = vim.v.count1, severity = { min = vim.diagnostic.severity.ERROR } } end, desc = 'Jump to the next diagnostic in the current buffer' , },
    { '[e', function() vim.diagnostic.jump { count = -vim.v.count1, severity = { min = vim.diagnostic.severity.ERROR } } end,  desc = 'Jump to the previous diagnostic in the current buffer' , },
    { mode = { 'n', 'v', 'i' }, '<Left>', '<nop>' },
    { mode = { 'n', 'v', 'i' }, '<Right>', '<nop>' },
    { mode = { 'n', 'v', 'i' }, '<Up>', '<nop>' },
    { mode = { 'n', 'v', 'i' }, '<Down>', '<nop>' },
  },
}

vim.diagnostic.config {
  underline = true,
  virtual_text = { virt_text_pos = 'eol_right_align' },
  virtual_lines = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'if_many',
    header = '',
  },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  group = vim.api.nvim_create_augroup('makeprg-c', { clear = true }),
  pattern = { '*.c', '*.h', '*.cpp', '*.hpp', '*.cxx', '*.hxx' },
  callback = function()
    vim.o.errorformat = vim.o.errorformat .. ',Test failed (%f:%l): %m'
    vim.o.makeprg = 'cmake --build build --config Debug --parallel'
  end,
})

local function setup_toggle_diagnostics()
  local diag_config_basic = true
  local virtual_line_config = { current_line = true }
  vim.keymap.set('n', '<leader>td', function()
    diag_config_basic = not diag_config_basic
    ---@param new vim.diagnostic.Opts
    local function set_config(new)
      local old = vim.diagnostic.config(nil)
      vim.diagnostic.config(vim.tbl_deep_extend('force', old or {}, new))
    end

    if diag_config_basic then
      ---@diagnostic disable-next-line: cast-local-type
      virtual_line_config = vim.diagnostic.config(nil).virtual_lines
      set_config { virtual_lines = false }
    else
      set_config { virtual_lines = virtual_line_config }
    end
  end, { desc = 'Toggle [d]iagnostic virtual_lines' })
end
setup_toggle_diagnostics()

local function godot_lsp_setup()
  local godot_project_path = vim.fs.root(0, 'project.godot')
  if not godot_project_path then
    return
  end

  if not vim.uv.fs_stat(godot_project_path .. '/server.pipe') then
    vim.fn.serverstart(godot_project_path .. '/server.pipe')
  end
end
godot_lsp_setup()

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  'editorconfig/editorconfig-vim',
  'tpope/vim-dispatch',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  {
    'github/copilot.vim',
    lazy = false,
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
    keys = {
      { mode = 'i', '<C-J>', 'copilot#Accept("\\<CR>")', expr = true, replace_keycodes = false },
    },
  },
  { 'brenoprata10/nvim-highlight-colors', opts = {} },
  { 'kaarmu/typst.vim', ft = 'typst' },
  { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = {} },
  { 'kylechui/nvim-surround', opts = {} },
  { 'mbbill/undotree', keys = { { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Toggle Undotree' } } },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      label = { rainbow = { enabled = false } },
      modes = { search = { enabled = false }, char = { enabled = false } },
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" }
    },
  },
  {
    'folke/snacks.nvim',
    lazy = false,
    opts = {
      input = { enabled = true },
      lazygit = { configure = true },
      picker = { ui_select = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'OilActionsPost',
        callback = function(event)
          if event.data.actions.type == 'move' then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
          end
        end,
      })
    end,
    -- stylua: ignore
    keys = {
      { '<leader>gl',function() require 'snacks'.lazygit.open() end, desc = "Open [G]it's [L]azygit" },
      { '<leader>sf',function() require 'snacks'.picker.files() end, desc = '[S]earch [F]iles' },
      { '<leader>sg',function() require 'snacks'.picker.git_grep() end, desc = '[S]earch by [G]rep' },
      { '<leader>sd',function() require 'snacks'.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
    },
  },
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      require('mini.basics').setup {
        options = {
          extra_ui = false,
        },
        mappings = { basic = false },
      }
      require('mini.bufremove').setup {}
      require('mini.cursorword').setup {}
      require('mini.trailspace').setup {}
    end,
    lazy = false,
    -- stylua: ignore
    keys = {
      { '<leader>bd', function() require('mini.bufremove').delete() end, desc = '[B]uffer delete' },
    },
  },
  {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    keys = { { '<leader>-', '<cmd>Oil<CR>', desc = 'Open parent directory' } },
    lazy = false,
    opts = {
      default_file_explorer = true,
    },
  },
  { 'folke/lazydev.nvim', ft = 'lua', opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } } },
  {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = 'rafamadriz/friendly-snippets',
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- keymap = { preset = 'mono' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      signature = { enabled = true },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
    },
  },
  {
    'folke/which-key.nvim',
    opts = {
      delay = 500,
      spec = {
        { '<leader>c', group = '[C]ode' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = 'Git [H]unk' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>', group = 'VISUAL <leader>', mode = 'v' },
        { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align',
        delay = 0,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
    },
    -- stylua: ignore
    keys = {
      { mode = 'v', '<leader>hs', function() require('gitsigns').stage_hunk {vim.fn.line '.', vim.fn.line 'v' } end, desc = 'Git [H]unk [S]tage' },
      { mode = 'v', '<leader>hr', function() require('gitsigns').reset_hunk {vim.fn.line '.', vim.fn.line 'v' } end, desc = 'Git [H]unk [R]eset' },
      { mode = 'n', '<leader>hs', function() require('gitsigns').stage_hunk()  end, desc = 'Git [H]unk [S]tage' },
      { mode = 'n', '<leader>hr', function() require('gitsigns').reset_hunk()  end, desc = 'Git [H]unk [R]eset' },
      { '<leader>hS', function() require('gitsigns').stage_buffer() end, desc = 'git [S]tage buffer' },
      { '<leader>hR', function() require('gitsigns').reset_buffer() end, desc = 'git [R]eset buffer' },
      { '<leader>hp', function() require('gitsigns').preview_hunk() end,  desc = 'git [P]review hunk' },
      { '<leader>hi', function() require('gitsigns').preview_hunk_inline() end,  desc = 'git preview hunk [i]nline' },
      { '<leader>gb', function() require('gitsigns').blame() end,  desc = 'git [B]lame file' },
      { '<leader>gd', function() require('gitsigns').diffthis() end,  desc = 'git [D]iff against index' },
      { '<leader>gD', function() require('gitsigns').diffthis '~' end,  desc = 'git [D]iff against last commit ~' },
      { '<leader>tb', function() require('gitsigns').toggle_current_line_blame() end,  desc = 'toggle git [B]lame line' },
      { mode = { 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>',  desc = 'select git [H]unk' },
      { mode = { 'n', 'v' }, '[c', function() require 'gitsigns'.nav_hunk 'prev' end, { expr = true, desc = 'Jump to next hunk' }},
      { mode = { 'n', 'v' }, ']c', function() require 'gitsigns'.nav_hunk 'next' end, { expr = true, desc = 'Jump to next hunk' }},
      { mode = { 'n', 'v' }, '[C', function() require 'gitsigns'.nav_hunk 'first' end, { expr = true, desc = 'Jump to next hunk' }},
      { mode = { 'n', 'v' }, ']C', function() require 'gitsigns'.nav_hunk 'last' end, { expr = true, desc = 'Jump to next hunk' }}
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = { flavour = 'mocha' },
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    opts = {},
    init = function()
      require('nvim-treesitter').setup {}
      local parsers = {
        'c',
        'cpp',
        'go',
        'lua',
        'python',
        'tsx',
        'javascript',
        'typescript',
        'vimdoc',
        'vim',
        'bash',
        'glsl',
        'markdown',
        'markdown_inline',
      }
      require('nvim-treesitter').install(parsers)

      local fts = {}
      for _, ft in ipairs(parsers) do
        vim.list_extend(fts, vim.treesitter.language.get_filetypes(ft))
      end

      vim.api.nvim_create_autocmd('FileType', {
        pattern = fts,
        group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
        callback = function(event)
          if vim.api.nvim_buf_line_count(event.buf) > 10000 then
            return
          end

          vim.treesitter.start()

          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    branch = 'main',
    opts = {
      select = { lookahead = true },
      move = { set_jumps = true },
    },
    -- stylua: ignore
    keys = {
      { mode = { 'o', 'x' }, 'af', function() require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects') end, desc = 'around [F]unction' },
      { mode = { 'o', 'x' }, 'if', function() require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects') end, desc = 'inside [F]unction' },
      { mode = { 'o', 'x' }, 'ac', function() require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects') end, desc = 'around [C]lass' },
      { mode = { 'o', 'x' }, 'ic', function() require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects') end, desc = 'inside [C]lass' },
      { '<leader>a', function() require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner') end, desc = 'Swap [A]rgument with next' },
      { '<leader>A', function() require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner') end, desc = 'Swap [A]rgument with previous' },
    },
  },
  {
    'mason-org/mason.nvim',
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'mason-org/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          vim.lsp.inlay_hint.enable(false)

          -- stylua: ignore
          vim.keymap.set_bulk {
            keys = {
              { '<leader>ti', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = '[T]oggle [I]nlay Hints' },
              { '<leader>ca', function() vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } } end, desc = '[C]ode [A]ction' },
              { '<leader>cf', function() vim.lsp.buf.code_action { context = { only = { 'quickfix' } } } end, desc = '[C]ode [F]ixes' },
              { 'gd',        vim.lsp.buf.definition, desc ='[G]oto [D]efinition' },
              { 'gD',        vim.lsp.buf.declaration, desc = '[G]oto [D]eclaration' },
            },
            opts = {
              buffer = event.buf,
            }
          }
        end,
      })

      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
      })

      local lsp_servers = {
        julials = {},
        gopls = {},
        pyright = {},
        html = { filetypes = { 'html', 'twig', 'hbs' } },
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              check = { command = 'clippy' },
              cargo = { features = 'all' },
            },
          },
        },
        clangd = {
          filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        },
        tinymist = {},
        cmake = {},
      }
      for server, config in pairs(lsp_servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end

      local ensure_installed = vim.tbl_keys(lsp_servers or {})
      vim.list_extend(ensure_installed, { 'stylua' })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- vim.lsp.config('elixirls', { cmd = { 'elixir-ls' } })
      vim.lsp.enable {
        'erlangls',
        'slangd',
        'gdscript',
        'zls',
        'elixirls',
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    -- stylua: ignore
    keys = {
      { '<leader>f', function() require('conform').format { async = true } end, desc = '[F]ormat buffer' },
    },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
        javascript = { 'prettier' },
        css = { 'prettier' },
        sql = { 'sqlfmt' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'jq' },
        toml = { 'taplo' },
      },
      default_format_opts = { lsp_format = 'fallback' },
      format_on_save = { timeout_ms = 500 },
      formatters = {
        shfmt = { prepend_args = { '-i', '2' } },
        sqlfmt = { prepend_args = { '-l', '120' } },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
  { 'ray-x/go.nvim', opts = {}, ft = { 'go', 'gomod' }, build = ':lua require("go.install").update_all_sync()' },
  {
    'monaqa/dial.nvim',
    init = function()
      local augend = require 'dial.augend'
      require('dial.config').augends:register_group {
        default = {
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.bool,
          augend.constant.new { elements = { 'true', 'false' }, preserve_case = true },
          augend.constant.new { elements = { 'on', 'off' }, preserve_case = true },
          augend.constant.new { elements = { 'yes', 'no' }, preserve_case = true },
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
          augend.semver.alias.semver,
        },
        typescript = {
          augend.constant.new { elements = { 'let', 'const' } },
        },
        visual = {},
      }
    end,
    -- stylua: ignore
    keys = {
      { mode = 'n', '<C-a>', function() require('dial.map').manipulate('increment', 'normal') end },
      { mode = 'n', '<C-x>', function() require('dial.map').manipulate('decrement', 'normal') end },
      { mode = 'n', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gnormal') end },
      { mode = 'n', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gnormal') end },
      { mode = 'v', '<C-a>', function() require('dial.map').manipulate('increment', 'visual') end },
      { mode = 'v', '<C-x>', function() require('dial.map').manipulate('decrement', 'visual') end },
      { mode = 'v', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gvisual') end },
      { mode = 'v', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gvisual') end },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
