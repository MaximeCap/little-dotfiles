local ensure = require("config.lazy").loader(
  { "https://github.com/folke/trouble.nvim" },
  function()
    require("trouble").setup {}
  end
)

local map = vim.keymap.set

map("n", "<leader>xx", function()
  ensure()
  vim.cmd "Trouble diagnostics toggle"
end, { desc = "Diagnostics (Trouble)" })

map("n", "<leader>xb", function()
  ensure()
  vim.cmd "Trouble diagnostics toggle filter.buf=0"
end, { desc = "Buffer Diagnostics (Trouble)" })

map("n", "<leader>xs", function()
  ensure()
  vim.cmd "Trouble symbols toggle focus=false"
end, { desc = "Symbols (Trouble)" })

map("n", "<leader>xr", function()
  ensure()
  vim.cmd "Trouble lsp toggle focus=false win.position=right"
end, { desc = "LSP Refs/Defs/Impls (Trouble)" })

map("n", "<leader>xl", function()
  ensure()
  vim.cmd "Trouble loclist toggle"
end, { desc = "Location List (Trouble)" })

map("n", "<leader>xq", function()
  ensure()
  vim.cmd "Trouble qflist toggle"
end, { desc = "Quickfix List (Trouble)" })
