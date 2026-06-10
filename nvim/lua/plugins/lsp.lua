local ensure = require("config.lazy").loader({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/j-hui/fidget.nvim",
}, function()
  require("fidget").setup {}

  local servers = {
    -- Language
    "lua_ls",
    "gopls",
    "vtsls",
    "tailwindcss",
    "basedpyright",
    "docker_language_server",
    -- Lint
    "eslint",
    "sqlfluff",
    -- Formatter
    "biome",
    "stylua",
    "ruff",
    "prettier",
    "goimports",
    "sqlfmt",
    -- dap
    "delve",
    "debugpy",
  }

  require("mason").setup {}
  require("mason-lspconfig").setup {
    automatic_enable = true,
  }
  require("mason-tool-installer").setup {
    ensure_installed = servers,
  }

  -- Advertise blink.cmp's richer completion capabilities to every LSP server.
  local ok_blink, blink = pcall(require, "blink.cmp")
  if ok_blink then
    vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities() })
  end

  vim.lsp.inlay_hint.enable()
end)

-- Diagnostic styling is cheap and doesn't pull plugins — set it up front
-- so messages render correctly the moment any LSP server attaches.
vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = true,
  underline = true,
  float = {
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
  },
  virtual_text = {
    spacing = 2,
    source = "if_many",
    prefix = "●",
  },
}

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("lazy_lsp", { clear = true }),
  once = true,
  callback = ensure,
})
