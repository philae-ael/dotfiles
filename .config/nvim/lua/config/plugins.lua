vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { { 'nvim-lua/plenary.nvim' } } }
  use { 'stevearc/dressing.nvim' }

  use { "ellisonleao/gruvbox.nvim" }
  use { 'rebelot/kanagawa.nvim' }
  use { "catppuccin/nvim", as = "catppuccin" }

  use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'nvim-treesitter/nvim-treesitter-context' }
  use { 'mbbill/undotree' }
  use { 'tpope/vim-fugitive' }
  use { 'lewis6991/gitsigns.nvim' }
  use {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end
  }

  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end
  }


  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      -- Snippet Collection (Optional)
      { 'rafamadriz/friendly-snippets' },
    }
  }

  use { "simrat39/rust-tools.nvim" }

  use { "folke/which-key.nvim" }
  use { "ThePrimeagen/harpoon" }
  use { 'f3fora/nvim-texlabconfig', { run = 'go build -o ~/.bin/' } }
  use { "lvimuser/lsp-inlayhints.nvim" }
  use { 'ray-x/go.nvim' }
  use { 'ray-x/guihua.lua' } -- recommended if need floating window support

  use 'nvim-lualine/lualine.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'folke/trouble.nvim'
end)
