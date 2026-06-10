-- Tier 3 entry point — runs from init.lua's vim.schedule, after Oil/Snacks
-- are already up. Each plugins/* file registers a lazy trigger; nothing
-- here calls setup() eagerly except gitsigns (statusline depends on it).

-- Gitsigns — eager (statusline reads vim.b.gitsigns_*).
require "plugins.gitsigns"

-- mini.pairs — InsertEnter is the right moment.
vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("lazy_mini_pairs", { clear = true }),
  once = true,
  callback = function()
    require("mini.pairs").setup {}
  end,
})

-- pack-manager — only needed when the user manages packs interactively.
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    vim.pack.add { "https://github.com/mplusp/pack-manager.nvim" }
  end,
})

-- Lazy-trigger registrations for the rest of the plugin set.
require "plugins.conform"
require "plugins.lsp"
require "plugins.lazydev"
require "plugins.treesitter"
require "plugins.autotag"
require "plugins.flash"
require "plugins.trouble"
require "plugins.obsidian"
require "plugins.dap"
require "plugins.tmux"
require "plugins.overseer"
require "plugins.surround"
require "plugins.todos"
require "plugins.avante"
require "plugins.ai"
require "plugins.lazygit"
require "plugins.claude"
require "plugins.codex"
require "plugins.likec4"
require "plugins.whichkey"

-- This file runs inside vim.schedule from init.lua, which executes after
-- VimEnter has already fired — so trigger VeryLazy directly.
vim.defer_fn(function()
  vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy", modeline = false })
end, 100)
