require("telescope").load_extension('harpoon')

require("which-key").register { ["<leader>h"] = { name = "Harpoon bindings" } }
vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Add" })
vim.keymap.set("n", "<leader>hd", require("harpoon.mark").rm_file, { desc = "Delete" })
vim.keymap.set("n", "<leader>ha", require("harpoon.mark").toggle_file, { desc = "Toggle" })
vim.keymap.set("n", "<leader>hp", require("harpoon.ui").nav_prev, { desc = "Prev" })
vim.keymap.set("n", "<leader>hn", require("harpoon.ui").nav_next, { desc = "Next" })
vim.keymap.set("n", "<leader>hu", require("harpoon.ui").toggle_quick_menu, { desc = "UI" })

vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end, { desc = "File 1" })
vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end, { desc = "File 2" })
vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end, { desc = "File 3" })
vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end, { desc = "File 4" })
vim.keymap.set("n", "<leader>5", function() require("harpoon.ui").nav_file(5) end, { desc = "File 5" })
vim.keymap.set("n", "<leader>6", function() require("harpoon.ui").nav_file(6) end, { desc = "File 6" })
vim.keymap.set("n", "<leader>7", function() require("harpoon.ui").nav_file(7) end, { desc = "File 7" })
vim.keymap.set("n", "<leader>8", function() require("harpoon.ui").nav_file(8) end, { desc = "File 8" })
vim.keymap.set("n", "<leader>9", function() require("harpoon.ui").nav_file(9) end, { desc = "File 9" })
