vim.g.mapleader       = ' '
vim.g.maplocalleader  = ' '
vim.opt.updatetime    = 250
vim.opt.timeoutlen    = 300

vim.opt.pumblend      = 10
vim.opt.pumheight     = 10
vim.opt.winblend      = 10
vim.opt.winborder     = 'rounded'
vim.opt.list          = true
vim.opt.tabstop       = 2
vim.opt.expandtab     = true
vim.opt.softtabstop   = 2
vim.opt.shiftwidth    = 2
vim.opt.swapfile      = false
vim.opt.concealcursor = ''
vim.opt.signcolumn    = 'yes'
vim.opt.grepprg       = "rg --vimgrep --smart-case --hidden"
vim.opt.grepformat    = "%f:%l:%c:%m"

vim.o.undofile        = true
vim.o.backup          = false
vim.o.writebackup     = false
vim.o.mouse           = 'a'
vim.cmd('filetype plugin indent on')
vim.o.breakindent   = true
vim.o.cursorline    = true
vim.o.linebreak     = true
vim.o.number        = true
vim.o.splitbelow    = true
vim.o.splitright    = true
vim.o.ruler         = false
vim.o.showmode      = false
vim.o.wrap          = false
vim.o.signcolumn    = 'yes'
vim.o.fillchars     = 'eob: '
vim.o.ignorecase    = true
vim.o.incsearch     = true
vim.o.infercase     = true
vim.o.smartcase     = true
vim.o.smartindent   = true
vim.o.completeopt   = 'menuone,noselect'
vim.o.virtualedit   = 'block'
vim.o.formatoptions = 'qjl1'
vim.opt.shortmess:append('WcC')
vim.o.splitkeep = 'screen'
vim.o.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,globals'


vim.opt.listchars:append {
  tab = '▎ ',
  extends = '…',
  precedes = '…',
  nbsp = '␣',
  conceal = '.',
}
vim.opt.fillchars:append { vert = '┃', horiz = '━', horizdown = '┳', horizup = '┻', verthoriz = '╋', vertleft = '┫', vertright = '┣' }
vim.filetype.add { extension = { frag = 'glsl', vert = 'glsl', typst = 'typst', asm = 'nasm', slang = 'shaderslang' } }

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[Y]ank into system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]], { desc = '[P]aste from system clipboard' })
vim.keymap.set('n', '<leader>P', [["+P]], { desc = '[P]aste from system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = '[Y]ank until the end of line into system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = '[D]elete without modifying registers' })
vim.keymap.set({ 'v' }, '<leader>zm', ":'<'>%!zm<cr>", { desc = 'Filter selection through [ZM]' })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = 'Visually select changed text' })
vim.keymap.set('n', ']e',
  function() vim.diagnostic.jump { count = vim.v.count1, severity = { min = vim.diagnostic.severity.ERROR } } end,
  { desc = 'Jump to the next diagnostic in the current buffer' })
vim.keymap.set('n', '[e',
  function() vim.diagnostic.jump { count = -vim.v.count1, severity = { min = vim.diagnostic.severity.ERROR } } end,
  { desc = 'Jump to the previous diagnostic in the current buffer' })
vim.keymap.set({ 'n', 'v', 'i' }, '<Left>', '<nop>')
vim.keymap.set({ 'n', 'v', 'i' }, '<Right>', '<nop>')
vim.keymap.set({ 'n', 'v', 'i' }, '<Up>', '<nop>')
vim.keymap.set({ 'n', 'v', 'i' }, '<Down>', '<nop>')

vim.keymap.set('n', '<leader>\\h', ':nohlsearch<CR>', { desc = 'Clear [H]ighlighted search' })

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

local function setup_lsp()
  require('mason').setup({})

  local lsp_servers = {
    julials = {},
    gopls = {},
    pyright = {},
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
  require("mason-lspconfig").setup {
    automatic_enable = true,
    ensure_installed = ensure_installed,
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
      vim.lsp.inlay_hint.enable(false)

      vim.keymap.set('n', '<leader>ti', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
        { desc = '[T]oggle [I]nlay Hints', buffer = event.buf })
      vim.keymap.set('n', '<leader>ca',
        function() vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } } end,
        { desc = '[C]ode [A]ction', buffer = event.buf })
      vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.code_action { context = { only = { 'quickfix' } } } end,
        { desc = '[C]ode [F]ixes', buffer = event.buf })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition', buffer = event.buf })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration', buffer = event.buf })
    end,
  })
end
local function setup_treesitter()
  local ts_parsers = {
    "bash",
    "c",
    "dockerfile",
    "fish",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "python",
    "rust",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "typst",
    "vim",
    "yaml",
    "zig",
  }

  local nts = require("nvim-treesitter")
  nts.install(ts_parsers)
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name, kind = ev.data.spec.name, ev.data.spec.kind
      if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
        nts.update()
      end
    end
  })

  require("treesitter-context").setup({
    max_lines = 3,
    multiline_threshold = 1,
    separator = '-',
    min_window_height = 20,
    line_numbers = true,
  })


  require('nvim-treesitter-textobjects').setup({
    select = { lookahead = true },
    move = { set_jumps = true },

  })
  vim.keymap.set({ 'o', 'x' }, 'af',
    function() require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects') end,
    { desc = 'around [F]unction' })
  vim.keymap.set({ 'o', 'x' }, 'if',
    function() require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects') end,
    { desc = 'inside [F]unction' })
  vim.keymap.set({ 'o', 'x' }, 'ac',
    function() require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects') end,
    { desc = 'around [C]lass' })
  vim.keymap.set({ 'o', 'x' }, 'ic',
    function() require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects') end,
    { desc = 'inside [C]lass' })

  -- Swap arguments
  vim.keymap.set('n', '<leader>a',
    function() require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner') end,
    { desc = 'Swap [A]rgument with next' })
  vim.keymap.set('n', '<leader>A',
    function() require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner') end,
    { desc = 'Swap [A]rgument with previous' })


  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local filetype = args.match
      local lang = vim.treesitter.language.get_lang(filetype)
      if vim.treesitter.language.add(lang) then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.treesitter.start()
      end
    end
  })
end


vim.pack.add({
  'https://github.com/tpope/vim-abolish',
  'https://github.com/nvim-tree/nvim-web-devicons',
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/Mofiqul/dracula.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",             version = 'main' },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  "https://github.com/neovim/nvim-lspconfig",
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tpope/vim-sleuth',
  'https://github.com/github/copilot.vim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/folke/flash.nvim',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/mbbill/undotree',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/saghen/blink.cmp',

  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',

  'https://github.com/stevearc/conform.nvim',
  'https://github.com/monaqa/dial.nvim',
  'https://github.com/j-hui/fidget.nvim',

  'https://github.com/mfussenegger/nvim-lint'
})


require("vim._extui").enable({})

require("dracula").setup({})
vim.cmd [[colorscheme dracula]]

setup_lsp()
setup_treesitter()
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")',
  { expr = true, replace_keycodes = false, silent = true, desc = 'Accept Copilot suggestion' })

require("todo-comments").setup({})
require("flash").setup({
  label = { rainbow = { enabled = false } },
  modes = { search = { enabled = false }, char = { enabled = false } },
})
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set('o', 'r', function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({ 'o', 'x' }, 'R', function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
vim.keymap.set('c', '<c-s>', function() require("flash").toggle() end, { desc = "Toggle Flash Search" })

require("snacks").setup({
  input = {},
  picker = { ui_select = true },
})
local snacks = require("snacks")
vim.keymap.set('n', '<leader>sf', function() snacks.picker.git_files({ untracked = true, submodules = true }) end,
  { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sb', snacks.picker.buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sg',
  function() snacks.picker.git_grep() end,
  { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>sd', snacks.picker.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.api.nvim_create_autocmd('User', {
  pattern = 'OilActionsPost',
  callback = function(event)
    if event.data.actions.type == 'move' then
      Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
    end
  end,
})

require('lazydev').setup({ library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } })

require("which-key").setup({
  delay = 500,
  spec = {
    { '<leader>c', group = '[C]ode' },
    { '<leader>g', group = '[G]it' },
    { '<leader>h', group = 'Git [H]unk' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>w', group = '[W]orkspace' },
    { '<leader>',  group = 'VISUAL <leader>',              mode = 'v' },
    { '<leader>h', group = 'Git [H]unk',                   mode = 'v' },
    { 'cr',        group = '[C]ase [R]eplace',             mode = 'v' },
    { 'crs',       desc = '[C]ase [R]eplace [s]nake_case', mode = { 'v', 'n' } },
    { 'crc',       desc = '[C]ase [R]eplace [c]amelCase',  mode = { 'v', 'n' } },
    { 'crm',       desc = '[C]ase [R]eplace [M]ixedCase',  mode = { 'v', 'n' } },
    { 'cr-',       desc = '[C]ase [R]eplace [-]-case',     mode = { 'v', 'n' } },
    { 'cr.',       desc = '[C]ase [R]eplace [.]-case',     mode = { 'v', 'n' } },
    { 'cru',       desc = '[C]ase [R]eplace [U]PPER_CASE', mode = { 'v', 'n' } },
  },
})

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndotree' })

require("oil").setup({ default_file_explorer = true, })
vim.keymap.set('n', '<leader>-', vim.cmd.Oil, { desc = 'Open Oil file explorer' })

require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'right_align',
    delay = 0,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
})
vim.keymap.set('v', '<leader>hs', function() require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
  { desc = 'Git [H]unk [S]tage' })
vim.keymap.set('v', '<leader>hr', function() require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
  { desc = 'Git [H]unk [R]eset' })

vim.keymap.set('n', '<leader>hs', function() require('gitsigns').stage_hunk() end, { desc = 'Git [H]unk [S]tage' })
vim.keymap.set('n', '<leader>hr', function() require('gitsigns').reset_hunk() end, { desc = 'Git [H]unk [R]eset' })
vim.keymap.set('n', '<leader>hS', function() require('gitsigns').stage_buffer() end, { desc = 'git [S]tage buffer' })
vim.keymap.set('n', '<leader>hR', function() require('gitsigns').reset_buffer() end, { desc = 'git [R]eset buffer' })
vim.keymap.set('n', '<leader>hp', function() require('gitsigns').preview_hunk() end, { desc = 'git [P]review hunk' })
vim.keymap.set('n', '<leader>gb', function() require('gitsigns').blame() end, { desc = 'git [B]lame file' })
vim.keymap.set('n', '<leader>gd', function() require('gitsigns').diffthis() end, { desc = 'git [D]iff against index' })
vim.keymap.set('n', '<leader>gD', function() require('gitsigns').diffthis('~') end,
  { desc = 'git [D]iff against last commit ~' })
vim.keymap.set('n', '<leader>tb', function() require('gitsigns').toggle_current_line_blame() end,
  { desc = 'toggle git [B]lame line' })

vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git [H]unk' })

vim.keymap.set({ 'n', 'v' }, '[c', function() require('gitsigns').nav_hunk('prev') end,
  { expr = true, desc = 'Jump to previous hunk' })
vim.keymap.set({ 'n', 'v' }, ']c', function() require('gitsigns').nav_hunk('next') end,
  { expr = true, desc = 'Jump to next hunk' })
vim.keymap.set({ 'n', 'v' }, '[C', function() require('gitsigns').nav_hunk('first') end,
  { expr = true, desc = 'Jump to first hunk' })
vim.keymap.set({ 'n', 'v' }, ']C', function() require('gitsigns').nav_hunk('last') end,
  { expr = true, desc = 'Jump to last hunk' })


require("nvim-surround").setup({})

require('conform').setup({
  format_on_save = {},
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'black' },
    go = { 'gofmt' },
    javascript = { 'prettierd' },
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    json = { 'jq' },
    html = { 'prettierd' },
    css = { 'prettierd' },
    scss = { 'prettierd' },
    markdown = { 'prettierd' },
    typst = { 'typstfmt' },
    sh = { 'shfmt' },
  },
  default_format_opts = { lsp_format = 'fallback' },

})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.keymap.set('n', '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat' })

local augend = require('dial.augend')
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
vim.keymap.set('n', '<C-a>', function() require('dial.map').manipulate('increment', 'normal') end)
vim.keymap.set('n', '<C-x>', function() require('dial.map').manipulate('decrement', 'normal') end)
vim.keymap.set('n', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gnormal') end)
vim.keymap.set('n', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gnormal') end)

vim.keymap.set('v', '<C-a>', function() require('dial.map').manipulate('increment', 'visual') end)
vim.keymap.set('v', '<C-x>', function() require('dial.map').manipulate('decrement', 'visual') end)
vim.keymap.set('v', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gvisual') end)
vim.keymap.set('v', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gvisual') end)

require('fidget').setup({})


local function build_blink(params)
  vim.notify('Building blink.cmp', vim.log.levels.INFO)
  local obj = vim.system({ 'cargo', 'build', '--release' }, { cwd = params.path }):wait()
  if obj.code == 0 then
    vim.notify('Building blink.cmp done', vim.log.levels.INFO)
  else
    vim.notify('Building blink.cmp failed', vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.spec.kind
    if name == 'blink.cmp' and (kind == 'install' or kind == 'update') then
      build_blink({ path = ev.data.path })
    end
  end,
})
require('blink.cmp').setup({
  keymap = { preset = 'default' },
  appearance = { nerd_font_variant = 'mono' },
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
  fuzzy = { implementation = 'prefer_rust_with_warning' },
})

local session_dir = vim.fn.expand('~/.cache/nvim/sessions/')
local function session_list()
  local sessions = vim.fn.globpath(session_dir, '*.vim', false, true)
  local session_names = {}
  for _, path in ipairs(sessions) do
    local name = vim.fn.fnamemodify(path, ':t:r')
    table.insert(session_names, name)
  end
  return session_names
end

-- @type SessionLoadConfig table
-- @field pseudo boolean|nil if true, load session in a pseudo manner (without setting vim.g.Sessionmgr_this_session)
--
-- @param name string
-- @param config SessionLoadConfig|nil
local function session_save(name, config)
  assert(type(name) == 'string' and #name > 0, 'Session name must be a non-empty string')

  if config == nil then
    config = {}
  end
  if not config.pseudo then
    vim.g.Sessionmgr_this_session = name
  end
  vim.fn.mkdir(session_dir, 'p')
  vim.cmd('mksession! ~/.cache/nvim/sessions/' .. name .. '.vim')
end

local function session_restart()
  session_save('last_session', { pseudo = true })
  vim.cmd('silent! restart Session load last_session')
end



-- @param name string
local function session_load(name)
  assert(type(name) == 'string' and #name > 0, 'Session name must be a non-empty string')

  local session_file = session_dir .. name .. '.vim'
  if vim.fn.filereadable(session_file) == 1 then
    vim.cmd('source ' .. session_file)
  else
    vim.notify('Session "' .. name .. '" does not exist.', vim.log.levels.ERROR)
  end
end

local function session_pick()
  local sessions = session_list()
  if #sessions == 0 then
    vim.notify('No sessions found', vim.log.levels.WARN)
    return
  end

  -- Build picker items with metadata
  local items = {}
  for _, name in ipairs(sessions) do
    local path = session_dir .. name .. '.vim'
    local mtime = vim.fn.getftime(path)
    local date = os.date('%Y-%m-%d %H:%M', mtime)

    table.insert(items, {
      text = name,
      file = path,
      mtime = mtime,
      date = date,
    })
  end

  -- Sort by modification time (newest first)
  table.sort(items, function(a, b)
    return a.mtime > b.mtime
  end)

  vim.ui.select(items, {
    prompt = 'Select a session to load:',
    format_item = function(item)
      return string.format('%-20s  [%s]', item.text, item.date)
    end,
  }, function(choice)
    if choice then
      session_load(choice.text)
    else
      vim.notify('Session loading cancelled', vim.log.levels.INFO)
    end
  end)
end

-- @param name string
local function session_delete(name)
  assert(type(name) == 'string' and #name > 0, 'Session name must be a non-empty string')
  local session_file = session_dir .. name .. '.vim'
  local ok, err = os.remove(session_file)
  if ok then
    vim.notify('Session "' .. name .. '" deleted.', vim.log.levels.INFO)
  else
    vim.notify('Error deleting session "' .. name .. '": ' .. err, vim.log.levels.ERROR)
  end
end

local function session_auto_save()
  local session_name = 'last_session'
  local config = { pseudo = true }

  if vim.g.Sessionmgr_this_session then
    session_name = vim.g.Sessionmgr_this_session
    config = { pseudo = false }
  end

  session_save(session_name, config)
end

vim.api.nvim_create_user_command('Session', function(opts)
  local args = opts.fargs
  if #args == 0 then
    if vim.g.Sessionmgr_this_session then
      vim.notify('Current session: ' .. vim.g.Sessionmgr_this_session, vim.log.levels.INFO)
    else
      vim.notify('No session currently loaded.', vim.log.levels.INFO)
    end
    return
  end

  local action = args[1]
  if action == 'save' then
    if #args < 2 then
      vim.notify('Session save requires a session name.', vim.log.levels.ERROR)
      return
    end
    session_save(args[2])
  elseif action == 'load' then
    if #args < 2 then
      vim.notify('Session load requires a session name.', vim.log.levels.ERROR)
      return
    end
    session_load(args[2])
  elseif action == 'restart' then
    session_restart()
  elseif action == 'delete' then
    if #args < 2 then
      vim.notify('Session delete requires a session name.', vim.log.levels.ERROR)
      return
    end
    session_delete(args[2])
  elseif action == 'pick' then
    session_pick()
  elseif action == 'exit' then
    vim.g.Sessionmgr_this_session = nil
  else
    vim.notify('Unknown Session action: ' .. action, vim.log.levels.ERROR)
  end
end, {
  desc = 'Manage sessions',
  nargs = '*',
  complete = function(ArgLead, CmdLine)
    local parts = vim.split(CmdLine, '%s+')
    if #parts == 2 then
      local commands = { 'save', 'load', 'restart', 'pick', 'delete', 'exit' }
      return vim.tbl_filter(function(cmd)
        return vim.startswith(cmd, ArgLead)
      end, commands)
    elseif #parts == 3 and (parts[2] == 'load' or parts[2] == 'save' or parts[2] == 'delete') then
      return vim.tbl_filter(function(name)
        return vim.startswith(name, ArgLead)
      end, session_list())
    else
      return {}
    end
  end
})



vim.api.nvim_create_autocmd('VimLeave', { callback = session_auto_save })
vim.keymap.set('n', '<leader>sl', session_pick, { desc = '[S]ession [L]oad' })

require('lint').linters_by_ft = {
  go = { 'golangcilint' },
  sh = { 'shellcheck' },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, { callback = function() require("lint").try_lint() end })
