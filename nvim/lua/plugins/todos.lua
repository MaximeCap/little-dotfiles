local ensure = require("config.lazy").loader(
  { "https://github.com/folke/todo-comments.nvim" },
  function()
    require("todo-comments").setup {}
  end
)

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = vim.api.nvim_create_augroup("lazy_todo_comments", { clear = true }),
  once = true,
  callback = ensure,
})
