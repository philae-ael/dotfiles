return {
  'stevearc/conform.nvim',
  opts = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettierd", "prettier" } },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
  init = function ()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end
}
