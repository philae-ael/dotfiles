return  {
  "zegervdv/nrpattern.nvim",
  config = function ()
    local patterns = require"nrpattern.default"
    patterns[{"true", "false"}] = {priority = 4}
    patterns[{"True", "False"}] = {priority = 5}
    require"nrpattern".setup(patterns)
  end
}
