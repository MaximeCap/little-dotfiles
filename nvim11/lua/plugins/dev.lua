return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{
				"<leader>tt",
				function()
					require("toggleterm").toggle(nil, nil, "", "float")
				end,
				desc = "Toggle Floating term",
			},
		},
		config = true,
	},
}
