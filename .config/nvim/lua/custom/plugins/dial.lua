return {
	"zegervdv/nrpattern.nvim",
	config = function()
		local patterns = require "nrpattern.default"
		patterns[{ "true", "false" }] = { priority = 4 }
		patterns[{ "True", "False" }] = { priority = 5 }
		patterns[{ "TRUE", "FALSE" }] = { priority = 5 }
		patterns[{ "on", "off" }] = { priority = 4 }
		patterns[{ "ON", "OFF" }] = { priority = 5 }
		patterns[{ "On", "Off" }] = { priority = 5 }
		patterns[{ "yes", "no" }] = { priority = 4 }
		patterns[{ "Yes", "No" }] = { priority = 5 }
		patterns[{ "NO", "YES" }] = { priority = 5 }
		require "nrpattern".setup(patterns)
	end
}
