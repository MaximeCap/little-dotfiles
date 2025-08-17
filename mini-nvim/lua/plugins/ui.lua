local M = {}

function M.setup()
	vim.pack.add({
		{ src = "https://github.com/olimorris/onedarkpro.nvim" },
		{ src = "https://github.com/lewis6991/gitsigns.nvim" },
		{ src = "https://github.com/nvim-lualine/lualine.nvim" }
	})

	require "onedarkpro".setup()
	require "lualine".setup()

	vim.cmd("colorscheme onedark")
end

return M
