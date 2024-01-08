local gitsigns = require("gitsigns")
gitsigns.setup({
  signcolumn = true,
  numhl = false,
  yadm = {
    enable = true
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local opts = function(desc) return { desc = desc, buffer = bufnr, remap = false } end

    require("which-key").register { ["<leader>g"] = { name = "Git bindings" } }
    vim.keymap.set({ "n", "v" }, "<leader>gs", gs.stage_hunk, opts("Stage current hunk"))
    vim.keymap.set({ "n", "v" }, "<leader>gr", gs.reset_hunk, opts("Reset current hunk"))
    vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, opts("Undo stage hunk"))
    vim.keymap.set("n", "<leader>gb", function()
      gs.blame_line { full = true }
    end, opts("Blame line"))
    vim.keymap.set("n", "<leader>gd", gs.diffthis, opts("Diff with last commit"))
    vim.keymap.set("n", "<leader>gD", function()
      gs.diffthis('~')
    end, opts("Diff with previous commit"))

      vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', opts("Select git hunk"))
  end
})
