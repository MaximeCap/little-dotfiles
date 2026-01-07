return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"fredrikaverpil/neotest-golang",
				version = "*", -- Optional, but recommended; track releases
				build = function()
					vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
				end,
			},
		},
		keys = {
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				desc = "Run test in file",
			},
			{
				"<leader>to",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle output panel",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle output panel",
			},
			{
				"<leader>tw",
				function()
					require("neotest").watch.toggle()
				end,
				desc = "Toggle output panel",
			},
		},
		config = function(_, opts)
			local config = {
				adapters = {
					require("neotest-golang")({
						testify_enabled = true,
						runner = "gotestsum", -- Optional, but recommended
					}),
				},
			}
			-- vim.tbl_deep_extend(opts, config)
			require("neotest").setup(config)
		end,
	},
}
