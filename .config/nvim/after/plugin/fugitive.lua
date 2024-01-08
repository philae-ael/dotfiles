require("which-key").register({ ["<leader>g"] = { name = "Git" } })
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git" })
