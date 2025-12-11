return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	keys = {
		{
			"<leader>f",
			function()
				require("snacks").picker.smart()
			end,
		},
		{
			"<leader>/",
			function()
				require("snacks").picker.grep()
			end,
		},
		{
			"<leader><leader>",
			function()
				require("snacks").picker.smart()
			end,
		},
		{
			"<leader>gg",
			function()
				require("snacks").lazygit()
			end,
		},
		{
			"<leader>m",
			function()
				require("snacks").picker.marks()
			end,
		},
	},
	opts = {
		picker = { enable = true },
		input = { enable = true },
		lazygit = { enable = true },
	},
	config = true,
}
