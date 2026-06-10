vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("lazy_treesitter_manager", { clear = true }),
  once = true,
  callback = function()
    vim.pack.add { "https://github.com/romus204/tree-sitter-manager.nvim" }
    require("tree-sitter-manager").setup {
      ensure_installed = {
        "tsx",
        "html",
        "go",
      },
      auto_install = true,
    }
  end,
})
