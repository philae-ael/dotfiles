local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Find git files" })
vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = "Find git files"})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = "Live grep" })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = "Buffers" })

require('dressing').setup({})
