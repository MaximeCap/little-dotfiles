local ensure = require("config.lazy").loader(
  { "https://github.com/stevearc/overseer.nvim" },
  function()
    require("overseer").setup {}
  end
)

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = vim.api.nvim_create_augroup("lazy_overseer", { clear = true }),
  once = true,
  callback = ensure,
})
