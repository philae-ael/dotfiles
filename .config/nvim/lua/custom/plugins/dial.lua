return {
    "monaqa/dial.nvim",
    keys = {
        { "n", "<C-a>", function()
            require("dial.map").manipulate("increment", "normal")
        end },
        { "n", "<C-x>", function()
            require("dial.map").manipulate("decrement", "normal")
        end },
        { "n", "g<C-a>", function()
            require("dial.map").manipulate("increment", "gnormal")
        end },
        { "n", "g<C-x>", function()
            require("dial.map").manipulate("decrement", "gnormal")
        end },
        { "v", "<C-a>", function()
            require("dial.map").manipulate("increment", "visual")
        end },
        { "v", "<C-x>", function()
            require("dial.map").manipulate("decrement", "visual")
        end },
        { "v", "g<C-a>", function()
            require("dial.map").manipulate("increment", "gvisual")
        end },
        { "v", "g<C-x>", function()
            require("dial.map").manipulate("decrement", "gvisual")
        end }
    }
}
