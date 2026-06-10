local ensure = require("config.lazy").loader(
  { "https://github.com/folke/flash.nvim" },
  function()
    require("flash").setup {}
  end
)

local map = vim.keymap.set

map({ "n", "x", "o" }, "s", function()
  ensure()
  require("flash").jump()
end, { desc = "Flash" })

map({ "n", "x", "o" }, "S", function()
  ensure()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })

map("o", "r", function()
  ensure()
  require("flash").remote()
end, { desc = "Remote Flash" })

map({ "o", "x" }, "R", function()
  ensure()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

map("c", "<c-s>", function()
  ensure()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })
