vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.swapfile = false
vim.opt.makeprg = 'make -j20'

vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.pumblend = 10 -- Make builtin completion menus slightly transparent
vim.o.pumheight = 10 -- Make popup menu smaller
vim.o.winblend = 10 -- Make floating windows slightly transparent

vim.opt.listchars = {
  tab = '▎ ',
  extends = '…',
  precedes = '…',
  nbsp = '␣',
}
vim.o.list = true

vim.filetype.add { extension = { frag = 'glsl', vert = 'glsl', typst = 'typst', asm = 'nasm', slang = 'shaderslang' } }

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
vim.keymap.set({ 'n', 'v' }, '<leader>cm', ':make<CR><CR>:botright cwindow<cr>')
vim.keymap.set({ 'v' }, '<leader>zm', ":'<'>%!zm<cr>")
vim.keymap.set({ 'n' }, '<leader>zm', ':%!zm<cr>')
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  'norcalli/nvim-colorizer.lua',
  {
    'ray-x/go.nvim',
    opts = {},
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    'brenoprata10/nvim-highlight-colors',
    opts = {
      render = 'virtual',
    },
  },
  { 'kaarmu/typst.vim', ft = 'typst' },
  { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {}, cond = not vim.g.vscode },
  { 'stevearc/dressing.nvim', opts = {} },
  {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    keys = { { '<leader>-', '<cmd>Oil<CR>', desc = 'Open parent directory' } },
    lazy = false,
    opts = {
      default_file_explorer = true,
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = { pipe_table = { style = 'normal' } },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      signature = { enabled = true },
      completion = {
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 500,
        },
      },
    },
    cond = not vim.g.vscode,
  },
  {
    'folke/which-key.nvim',
    opts = {
      icons = {
        mappings = vim.g.have_nerd_font,
      },
      delay = 500,
      spec = {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = 'Git [H]unk' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>', group = 'VISUAL <leader>', mode = 'v' },
        { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
      },
    },
    cond = not vim.g.vscode,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      on_attach = function(bufnr)
        local gs = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        local function mapnodiff(mode, l, r, opts)
          map(mode, l, function()
            if vim.wo.diff then
              return l
            end
            vim.schedule(r)
            return '<Ignore>'
          end, opts)
        end

        -- stylua: ignore start
        mapnodiff({ 'n', 'v' }, '[c', function() gs.nav_hunk 'prev' end, { expr = true, desc = 'Jump to next hunk' })
        mapnodiff({ 'n', 'v' }, ']c', function() gs.nav_hunk 'next' end, { expr = true, desc = 'Jump to next hunk' })
        mapnodiff({ 'n', 'v' }, '[C', function() gs.nav_hunk 'first' end, { expr = true, desc = 'Jump to next hunk' })
        mapnodiff({ 'n', 'v' }, ']C', function() gs.nav_hunk 'last' end, { expr = true, desc = 'Jump to next hunk' })

        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'reset git hunk' })
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>hb', function() gs.blame_line { full = false } end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function() gs.diffthis '~' end, { desc = 'git diff against last commit' })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
        -- stylua: ignore end
      end,
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'mocha',
    },
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
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
          fzf = {},
        },
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      }

      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'ui-select'
    end,
    -- stylua: ignore
    keys = {
        { '<leader>?',function() require('telescope.builtin').oldfiles() end,                      desc = '[?] Find recently opened files',},
        { '<leader><space>',function() require('telescope.builtin').buffers() end,                 desc = '[ ] Find existing buffers' },
        { '<leader>/',function() require('telescope.builtin').current_buffer_fuzzy_find() end,     desc = '[/] Fuzzily search in current buffer' },
        { '<leader>s/',function()
            require('telescope.builtin').live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
          end, desc = '[S]earch [/] in Open Files' },
        { '<leader>ss',function() require('telescope.builtin').builtin() end,                      desc = '[S]earch [S]elect Telescope' },
        { '<leader>gf',function() require('telescope.builtin').git_files() end,                    desc = 'Search [G]it [F]iles' },
        { '<leader>sf',function() require('telescope.builtin').find_files() end,                   desc = '[S]earch [F]iles' },
        { '<leader>sh',function() require('telescope.builtin').help_tags() end,                    desc = '[S]earch [H]elp' },
        { '<leader>sw',function() require('telescope.builtin').grep_string() end,                  desc = '[S]earch current [W]ord' },
        { '<leader>sg',function() require('telescope.builtin').live_grep() end,                    desc = '[S]earch by [G]rep' },
        { '<leader>sd',function() require('telescope.builtin').diagnostics() end,                  desc = '[S]earch [D]iagnostics' },
        { '<leader>sr',function() require('telescope.builtin').resume() end,                       desc = '[S]earch [R]esume' },
      }
,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
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
        },

        auto_install = true,
        sync_install = false,
        ignore_install = { 'rust' },
        modules = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          use_languagetree = false,
          disable = function(_, bufnr)
            local buf_name = vim.api.nvim_buf_get_name(bufnr)
            local file_size = vim.api.nvim_call_function('getfsize', { buf_name })
            return file_size > 256 * 1024
          end,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'g<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
  },
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup {}
      require('mini.align').setup {}
      require('mini.basics').setup {
        options = {
          extra_ui = false,
        },
        mappings = { basic = false, option_toggle_prefix = '<leader>\\' },
      }
      require('mini.bufremove').setup {}
      -- require('mini.cursorword').setup {}
      require('mini.operators').setup {}
      require('mini.trailspace').setup {}
      require('mini.surround').setup {}
    end,
    lazy = false,
    -- stylua: ignore
    keys = {
      { '<leader>bd', function() require('mini.bufremove').delete() end, desc = '[B]uffer delete' },
    },
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = '[L]ocation List' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = '[Q]uickfix List' },
      { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = '[S]ymbols' },
      { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = '[L]SP Definitions / references / ...' },
    },
  },
  'editorconfig/editorconfig-vim',
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim' },
      'williamboman/mason-lspconfig.nvim',
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- if client then
          --   client.server_capabilities.semanticTokensProvider = nil
          -- end

          local nmap = function(keys, func, desc)
            if desc then
              desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
          end
          local imap = function(keys, func, desc)
            if desc then
              desc = 'LSP: ' .. desc
            end

            vim.keymap.set('i', keys, func, { buffer = event.buf, desc = desc })
          end

          nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          nmap('<leader>cf', function()
            vim.lsp.buf.code_action { context = { only = { 'quickfix' } } }
          end, '[C]ode [F]ixes')
          nmap('<leader>ca', function()
            vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
          end, '[C]ode [A]ction')
          nmap('<leader>cr', function()
            vim.lsp.buf.rename()
          end, '[C]ode [R]ename')

          nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- See `:help K` for why this keymap
          nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
          nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
          imap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

          -- Lesser used LSP functionality
          nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
          nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
          nmap('<leader>wl', function()
            vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, '[W]orkspace [L]ist Folders')

          nmap('<leader>ti', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[T]oggle [I]nlay Hints')
          vim.lsp.inlay_hint.enable(false)

          -- Create a command `:Format` local to the LSP buffer
          vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if not vim.g.vscode then
        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
      end

      local servers = {
        clangd = {},
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
      }
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      require('lspconfig').slangd.setup {
        capabilities = capabilities,
      }
    end,
  },
  { 'mrcjkb/rustaceanvim', version = '^5', lazy = false },
  { import = 'custom.plugins' },
}, {})

-- vim: ts=2 sts=2 sw=2 et
