local M = {}

function M.setup()
	require("tokyonight").setup {
		style = "storm",
		transparent = true,
	}
	require "gruvbox".setup {
		terminal_colors = true,
	}

	require("mini.icons").setup {}
	require("slimline").setup {
		components_inactive = {
			left = { 'path' },
		}
	}

	-- require "lualine".setup({
	-- 	sections = {
	-- 		lualine_x = {
	-- 			-- {
	-- 			-- 	require "minuet.lualine",
	-- 			-- 	display_name = 'provider',
	-- 			-- 	display_on_idle = true
	-- 			-- },
	-- 			'encoding',
	-- 			'fileformat',
	-- 			'filetype'
	-- 		}
	-- 	}
	-- })


	local nvim_tmux_nav = require("nvim-tmux-navigation")
	nvim_tmux_nav.setup {}

	vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
	vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
	vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
	vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
	vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
	vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

	require("toggleterm").setup {}
	require("flash").setup {}
	require("todo-comments").setup {}
	local whichKey = require("which-key")
	whichKey.setup()

	-- vim.keymap.set("n", "<leader>?", whichKey.show({ global = false }))
	vim.keymap.set("n", "<leader>ul", ":lua vim.o.background = \"light\"<CR>")
	vim.keymap.set("n", "<leader>ud", ":lua vim.o.background = \"dark\"<CR>")


	--vim.o.background = theme

	vim.cmd("colorscheme tokyonight")
end

return M
