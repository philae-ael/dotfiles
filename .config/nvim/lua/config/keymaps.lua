-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without changing paste register" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy end of line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete word without changing registers" })


