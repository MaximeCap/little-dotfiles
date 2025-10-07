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
vim.opt.splitright = true
vim.opt.splitbelow = true

local map = vim.keymap.set

vim.g.mapleader = " "

vim.pack.add({
	-- Base region
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter",          version = "master" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/echasnovski/mini.surround" },
	{ src = "https://github.com/saghen/blink.cmp",                         version = "v1.6.0" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/milanglacier/minuet-ai.nvim" },
	-- Debug region
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = 'https://github.com/jay-babu/mason-nvim-dap.nvim' },
	{ src = 'https://github.com/leoluz/nvim-dap-go' },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
	-- LSP region
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/stevearc/conform.nvim' },
	{ src = 'https://github.com/j-hui/fidget.nvim' },
	{ src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
	{ src = 'https://github.com/qvalentin/helm-ls.nvim' },
	-- UI region
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/pmizio/typescript-tools.nvim" },
	{ src = "https://github.com/nvim-mini/mini.files" }
})

require "nvim-autopairs".setup()
require "mini.surround".setup()

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


require "plugins.ai".setup()
require "plugins.lsp".setup()
require "plugins.ui".setup()
require "plugins.debug".setup()
require "after"

-- require "oil".setup {
-- 	view_options = {
-- 		show_hidden = true
-- 	}
-- }
local MiniFiles = require('mini.files')
MiniFiles.setup {}

map("n", "<leader>f", function() snacks.picker.smart() end)
map("n", "<leader>/", function() snacks.picker.grep() end)
map("n", "<leader><leader>", function() snacks.picker.smart() end)
map("n", "<leader>e", function() MiniFiles.open() end)
map("n", "<leader>gg", function() snacks.lazygit() end)

vim.cmd(":hi statusline guibg=NONE")
