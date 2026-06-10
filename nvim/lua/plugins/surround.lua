-- mini.nvim itself is already added in init.lua's Tier 2. We only need to
-- defer the setup() call until the editor is idle.
local ensure = require("config.lazy").loader(nil, function()
  require("mini.surround").setup {
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
    },
  }
end)

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = vim.api.nvim_create_augroup("lazy_surround", { clear = true }),
  once = true,
  callback = ensure,
})
