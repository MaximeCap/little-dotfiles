local ensure = require("config.lazy").loader({ "https://github.com/johnseth97/codex.nvim" }, function()
  require("codex").setup {
    keymaps = {
      toggle = "<A-\\>",
    },
    panel = true,
    width = 0.4,
  }
end)

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = vim.api.nvim_create_augroup("lazy_codex", { clear = true }),
  once = true,
  callback = ensure,
})
