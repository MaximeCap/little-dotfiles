local ensure = require("config.lazy").loader({ "https://github.com/greggh/claude-code.nvim" }, function()
  require("claude-code").setup {
    window = {
      position = "vertical",
    },
    keymaps = {
      toggle = {
        normal = "<C-\\>",
        terminal = "<C-\\>",
      },
    },
  }
end)

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = vim.api.nvim_create_augroup("lazy_claude", { clear = true }),
  once = true,
  callback = ensure,
})
