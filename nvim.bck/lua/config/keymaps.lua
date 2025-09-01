-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", {})

vim.keymap.set("n", "<A-C-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-C-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-C-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-C-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
