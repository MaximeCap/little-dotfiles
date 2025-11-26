return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		enabled = true,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	-- Lua
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		-- undo-glow.lua
		"y3owk1n/undo-glow.nvim",
		version = "*", -- remove this if you want to use the `main` branch
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			animation = {
				enabled = true, -- whether to turn on or off for animation
				duration = 400, -- in ms
				animation_type = "fade", -- default to "fade", see more at animation section on how to change or create your own
				fps = 120, -- change the fps, normally either 60 / 120, but it can be whatever number
				easing = "in_out_cubic",
				window_scoped = true,
			},
		},
		keys = {
			{
				"u",
				function()
					require("undo-glow").undo()
				end,
				mode = "n",
				desc = "Undo with highlight",
				noremap = true,
			},
			{
				"U",
				function()
					require("undo-glow").redo()
				end,
				mode = "n",
				desc = "Redo with highlight",
				noremap = true,
			},
			{
				"p",
				function()
					require("undo-glow").paste_below()
				end,
				mode = "n",
				desc = "Paste below with highlight",
				noremap = true,
			},
			{
				"P",
				function()
					require("undo-glow").paste_above()
				end,
				mode = "n",
				desc = "Paste above with highlight",
				noremap = true,
			},
			{
				"n",
				function()
					require("undo-glow").search_next({
						animation = {
							animation_type = "strobe",
						},
					})
				end,
				mode = "n",
				desc = "Search next with highlight",
				noremap = true,
			},
			{
				"N",
				function()
					require("undo-glow").search_prev({
						animation = {
							animation_type = "strobe",
						},
					})
				end,
				mode = "n",
				desc = "Search prev with highlight",
				noremap = true,
			},
			{
				"*",
				function()
					require("undo-glow").search_star({
						animation = {
							animation_type = "strobe",
						},
					})
				end,
				mode = "n",
				desc = "Search star with highlight",
				noremap = true,
			},
			{
				"#",
				function()
					require("undo-glow").search_hash({
						animation = {
							animation_type = "strobe",
						},
					})
				end,
				mode = "n",
				desc = "Search hash with highlight",
				noremap = true,
			},
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
}
