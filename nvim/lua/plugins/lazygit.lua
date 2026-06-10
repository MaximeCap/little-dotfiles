local ensure = require("config.lazy").loader({
  "https://github.com/kdheepak/lazygit.nvim",
}, function()
  vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Lazygit" })
end)

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = vim.api.nvim_create_augroup("lazy_lazygit", { clear = true }),
  once = true,
  callback = function()
    if vim.uv.fs_stat ".git" then
      ensure()
    end
  end,
})
