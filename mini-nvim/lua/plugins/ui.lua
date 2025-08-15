local M = {}

function M.setup()
	vim.pack.add({
		{ src = "https://github.com/olimorris/onedarkpro.nvim" },
	})

	require "onedarkpro".setup()

	vim.cmd("colorscheme onedark")
end

return M
