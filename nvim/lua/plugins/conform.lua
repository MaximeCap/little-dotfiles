local ensure = require("config.lazy").loader({ "https://github.com/stevearc/conform.nvim" }, function()
  require("conform").setup {
    formatters_by_ft = {
      lua = { "stylua" },
      css = { "prettier" },
      html = { "prettier" },
      go = { "goimports", "gofumpt" },
      javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
      typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
      python = { "ruff" },
      sql = { "sqlfmt", "pgformatter" },
    },
    format_on_save = {
      timeout_ms = 1200,
      lsp_fallback = true,
    },
  }
end)

-- First save: load conform and run the format on this buffer manually,
-- since conform.setup's own BufWritePre hook is registered too late to
-- catch the very first save.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("lazy_conform", { clear = true }),
  once = true,
  callback = function(args)
    ensure()
    require("conform").format { bufnr = args.buf, lsp_fallback = true, timeout_ms = 1200 }
  end,
})

vim.keymap.set({ "n", "x" }, "<leader>fm", function()
  ensure()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })
