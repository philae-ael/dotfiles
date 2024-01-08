vim.o.background = "dark"
require("catppuccin").setup({
  custom_highlights = function(colors)
    return {
      GitSignsAdd = { fg = colors.teal },
      GitSignsChange = { fg = colors.lavender },
      GitSignsDelete = { fg = colors.maroon },
    }
  end,
  integrations = {
    gitsigns = true,
  }
})

vim.cmd.colorscheme("catppuccin-mocha")
