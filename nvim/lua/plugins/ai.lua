local ensure = require("config.lazy").loader(
  { "https://github.com/carlos-algms/agentic.nvim" },
  function()
    require("agentic").setup {
      provider = "codex-acp",
    }
  end
)

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = vim.api.nvim_create_augroup("lazy_agentic", { clear = true }),
  once = true,
  callback = ensure,
})
