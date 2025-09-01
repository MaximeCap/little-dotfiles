local M = {}

function M.setup()
	vim.pack.add({
		{ src = "https://github.com/olimorris/onedarkpro.nvim" },
		{ src = "https://github.com/lewis6991/gitsigns.nvim" },
		{ src = "https://github.com/nvim-lualine/lualine.nvim" }
	})

	require "onedarkpro".setup {
		options = {
			transparency = true
		}
	}
	require "lualine".setup({
		sections = {
			lualine_x = {
				{
					require "minuet.lualine",
					display_name = 'provider',
					display_on_idle = true
				},
				'encoding',
				'fileformat',
				'filetype'
			}
		}
	})

	vim.cmd("colorscheme onedark")
end

return M
