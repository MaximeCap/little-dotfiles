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
			"<leader>fr",
			function()
				require("snacks").picker.recent()
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
		-- git
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
	},
	opts = {
		picker = { enable = true },
		input = { enable = true },
		lazygit = { enable = true },
	},
	config = true,
}
