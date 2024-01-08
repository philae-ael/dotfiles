require("trouble").setup {

}

local opts = function(desc) return { desc = desc, silent = true, remap = false } end

require("which-key").register { ["<leader>t"] = { name = "Trouble bindings" } }
vim.keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<cr>", opts("Toggle Trouble"))
vim.keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  opts("Toggle workspace diagnostics")
)
vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>",
  opts("Toggle document diagnostics")
)
vim.keymap.set("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>",
  opts("Toggle loclist")
)
vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",
  opts("Toggle quickfix")
)
vim.keymap.set("n", "<leader>tr", "<cmd>TroubleToggle lsp_references<cr>",
  opts("Toggle references")
)
