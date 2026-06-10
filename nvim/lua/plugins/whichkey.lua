local ensure = require("config.lazy").loader({ "https://github.com/folke/which-key.nvim" }, function()
  require("which-key").setup()
end)

vim.keymap.set("n", "<leader>?", function()
  ensure()
  require("which-key").show { global = false }
end)

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = vim.api.nvim_create_augroup("lazy_whichkey", { clear = true }),
  once = true,
  callback = ensure,
})
