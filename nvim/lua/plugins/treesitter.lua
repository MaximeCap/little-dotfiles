return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		config = function()
			local toInstall = require("config.treesitter")
			require("nvim-treesitter").install(toInstall)
		end,
	},
}
