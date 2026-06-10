local ensure = require("config.lazy").loader(
  { "https://github.com/numToStr/Navigator.nvim" },
  function()
    require("Navigator").setup {}
  end
)

local map = vim.keymap.set
map({ "n", "t" }, "<C-h>", function()
  ensure()
  vim.cmd "NavigatorLeft"
end)
map({ "n", "t" }, "<C-l>", function()
  ensure()
  vim.cmd "NavigatorRight"
end)
map({ "n", "t" }, "<C-k>", function()
  ensure()
  vim.cmd "NavigatorUp"
end)
map({ "n", "t" }, "<C-j>", function()
  ensure()
  vim.cmd "NavigatorDown"
end)
