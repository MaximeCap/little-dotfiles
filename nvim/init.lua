vim.g.mapleader = " "

require "config.options"

-- Tier 1 — pre-paint: colorscheme so the very first frame is correct.
vim.pack.add { "https://github.com/rebelot/kanagawa.nvim" }
require("kanagawa").setup {}
vim.cmd "colorscheme kanagawa"

local state_file = vim.fn.stdpath "state" .. "/bg_state"

local f = io.open(state_file, "r")

if f then
  local saved_bg = f:read "*l"
  f:close()
  if saved_bg == "dark" or saved_bg == "light" then
    vim.o.background = saved_bg
  end
end

local function toggle_background()
  -- Toggle the setting
  local new_bg = vim.o.background == "dark" and "light" or "dark"
  vim.o.background = new_bg

  -- Save the new setting to the state file
  local file = io.open(state_file, "w")
  if file then
    file:write(new_bg)
    file:close()
    print("Background set to " .. new_bg .. " (saved)")
  end
end

vim.keymap.set("n", "<leader>us", toggle_background, { desc = "Toggle between light and dar" })

-- Pure-Lua statusline; no plugin deps.
require "config.statusline"

require "config.mappings"
require "config.autocmds"

-- Tier 2 — scheduled: stand up Oil + Snacks before the user can press a key.
vim.schedule(function()
  -- Oil
  vim.pack.add { "https://github.com/stevearc/oil.nvim" }
  require("oil").setup {
    win_options = {
      signcolumn = "yes:1",
    },
    view_options = {
      show_hidden = true,
    },
  }
  vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>")

  -- mini.nvim shell — needed for icons (Oil + statusline) and
  -- pairs/surround which load lazily later.
  vim.pack.add { "https://github.com/nvim-mini/mini.nvim" }
  require("mini.icons").setup {}

  -- Snacks
  vim.pack.add { "https://github.com/folke/snacks.nvim" }
  require("snacks").setup {
    input = { enabled = true },
    picker = { enabled = true, layout = "ivy" },
  }
  local map = vim.keymap.set
  map("n", "<leader><leader>", function()
    Snacks.picker.files()
  end, { desc = "Files" })
  map("n", "<leader>fg", function()
    Snacks.picker.grep()
  end, { desc = "Grep" })
  map("n", "<leader>fb", function()
    Snacks.picker.buffers()
  end, { desc = "Buffers" })
  map("n", "<leader>fh", function()
    Snacks.picker.help()
  end, { desc = "Help" })
  map("n", "<leader>fws", function()
    Snacks.picker.lsp_workspace_symbols()
  end, { desc = "Workspace symbols" })

  -- Tier 3 — register lazy triggers for everything else.
  require "config"
end)
