-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local opt = vim.opt

opt.autowrite = false
opt.clipboard = ""
opt.conceallevel = 0
opt.confirm = false

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.spelllang = { "en", "fr" }

opt.mouse = "a"
