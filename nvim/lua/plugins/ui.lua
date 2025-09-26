local M = {}

function M.setup()
	require "gruvbox".setup {
		terminal_colors = true,
	}

	require "lualine".setup({
		sections = {
			lualine_x = {
				-- {
				-- 	require "minuet.lualine",
				-- 	display_name = 'provider',
				-- 	display_on_idle = true
				-- },
				'encoding',
				'fileformat',
				'filetype'
			}
		}
	})

	require("toggleterm").setup {}
	require("flash").setup {}
	require("todo-comments").setup {}
	local whichKey = require("which-key")
	whichKey.setup()

	-- vim.keymap.set("n", "<leader>?", whichKey.show({ global = false }))
	vim.keymap.set("n", "<leader>ul", ":lua vim.o.background = \"light\"<CR>")
	vim.keymap.set("n", "<leader>ud", ":lua vim.o.background = \"dark\"<CR>")


	--vim.o.background = theme

	vim.cmd("colorscheme gruvbox")
end

return M
