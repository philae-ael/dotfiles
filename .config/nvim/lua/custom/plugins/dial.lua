return {
    "monaqa/dial.nvim",
    config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group {
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias["%Y/%m/%d"],
            },
            typescript = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.constant.new { elements = { "let", "const" } },
            },
            visual = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias["%Y/%m/%d"],
                augend.constant.alias.alpha,
                augend.constant.alias.Alpha,
            },
        }
    end,
    keys = {
        { mode = "n", "<C-a>",  function() require("dial.map").manipulate("increment", "normal") end },
        { mode = "n", "<C-x>",  function() require("dial.map").manipulate("decrement", "normal") end },
        { mode = "n", "g<C-a>", function() require("dial.map").manipulate("increment", "gnormal") end },
        { mode = "n", "g<C-x>", function() require("dial.map").manipulate("decrement", "gnormal") end },
        { mode = "v", "<C-a>",  function() require("dial.map").manipulate("increment", "visual") end },
        { mode = "v", "<C-x>",  function() require("dial.map").manipulate("decrement", "visual") end },
        { mode = "v", "g<C-a>", function() require("dial.map").manipulate("increment", "gvisual") end },
        { mode = "v", "g<C-x>", function() require("dial.map").manipulate("decrement", "gvisual") end }
    }
}
