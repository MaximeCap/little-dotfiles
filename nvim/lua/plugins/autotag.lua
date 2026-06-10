vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "html",
    "xml",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "tsx",
    "jsx",
    "vue",
    "svelte",
    "astro",
    "markdown",
  },
  group = vim.api.nvim_create_augroup("lazy_autotag", { clear = true }),
  once = true,
  callback = function()
    vim.pack.add { "https://github.com/windwp/nvim-ts-autotag" }
    require("nvim-ts-autotag").setup {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    }
  end,
})
