require("hop").setup()

local hop = require('hop')
local function opts(desc)
  return {remap = true, desc=desc}
end
local directions = require('hop.hint').HintDirection

vim.keymap.set('', '<leader>f', function()
  hop.hint_char2({ direction = directions.AFTER_CURSOR })
end, opts("Hop to char"))

vim.keymap.set('', '<leader>F', function()
  hop.hint_char2({ direction = directions.BEFORE_CURSOR })
end, opts("Hop to char (Backward)"))

vim.keymap.set('', '<leader>t', function()
  hop.hint_char2({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
end, opts("Hop until char"))

vim.keymap.set('', '<leader>T', function()
  hop.hint_char2({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
end, opts("Hop until char (Backward)"))

vim.keymap.set('', '<leader>w', function()
  hop.hint_words({ direction = directions.AFTER_CURSOR})
end, opts("Hop to word"))

vim.keymap.set('', '<leader>W', function()
  hop.hint_words({ direction = directions.BEFORE_CURSOR})
end, opts("Hop to word (Backward)"))

vim.keymap.set('', '<leader>/', hop.hint_patterns, opts("Hop to pattern"))
