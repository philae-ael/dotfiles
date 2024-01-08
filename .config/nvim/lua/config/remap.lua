vim.g.mapleader = " "

require("which-key").register({
    ["<leader>p"] = { name = "Explore project" }
})
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block down" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "join line with next line" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "scroll down one page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "scroll up one page" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without changing paste register" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy end of line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete word without changing registers" })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Goto next quickfix item" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Goto previous quickfix item" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Goto next loclist item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Goto prev loclist item" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "find and replace current word" })
