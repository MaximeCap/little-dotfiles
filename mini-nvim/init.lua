vim.opt.winborder = "rounded"
vim.opt.signcolumn = "yes"
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.tabstop = 2

local map = vim.keymap.set

vim.g.mapleader = " "

vim.pack.add({
	{ src = "https://github.com/olimorris/onedarkpro.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" }
})


require "nvim-treesitter.configs".setup {
	ensure_installed = { "go" },
	auto_install = true,
	highlight = {
		enable = true
	}
}

require "mini.pick".setup()
require "oil".setup()
require "after.files".setup()
require "after.lsp".setup()

map("n", "<leader>f", ":Pick files<CR>")
map("n", "<leader><leader>", ":Pick files<CR>")
map("n", "<leader>e", ":Oil<CR>")

require "onedarkpro".setup()

vim.cmd("colorscheme onedark")
vim.cmd(":hi statusline guibg=NONE")
