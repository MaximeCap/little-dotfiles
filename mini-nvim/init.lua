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
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

local map = vim.keymap.set

vim.g.mapleader = " "

vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
	{ src = "https://github.com/folke/snacks.nvim" }
})

local snacks = require "snacks"

snacks.setup({
	picker = { enable = true },
	input = { enable = true },
	lazygit = { enable = true },
})

require "nvim-treesitter.configs".setup {
	ensure_installed = { "go" },
	auto_install = true,
	highlight = {
		enable = true
	}
}

require "plugins.ui".setup()
require "plugins.lsp".setup()
require "plugins.debug".setup()

require "oil".setup()
require "after.files".setup()

map("n", "<leader>f", function() snacks.picker.smart() end)
map("n", "<leader><leader>", function() snacks.picker.smart() end)
map("n", "<leader>e", ":Oil<CR>")
map("n", "<leader>gg", function() snacks.lazygit() end)

vim.cmd(":hi statusline guibg=NONE")
