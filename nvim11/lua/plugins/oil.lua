return {
	{
		"A7Lavinraj/fyler.nvim",
		dependencies = { "nvim-mini/mini.icons" },
		branch = "stable", -- Use stable branch for production
		opts = {},
		keys = {
			{
				"<leader>e",
				"<cmd>Fyler kind=float<cr>",
				desc = "Open file tree",
			},
		},
	},
	{
		"stevearc/oil.nvim",
		enabled = false,
		cmd = "Oil",
		keys = {
			{ "<leader>e", "<cmd>Oil<cr>" },
		},
		dependencies = {
			"refractalize/oil-git-status.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			win_options = {
				signcolumn = "yes:2",
			},
			view_options = {
				show_hidden = true,
			},
		},
		config = function(_, opts)
			require("oil").setup(opts)
			require("oil-git-status").setup({
				show_ignored = false,
			})
		end,
	},
}
