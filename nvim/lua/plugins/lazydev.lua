vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  group = vim.api.nvim_create_augroup("lazy_lazydev", { clear = true }),
  once = true,
  callback = function()
    vim.pack.add { "https://github.com/folke/lazydev.nvim" }
    require("lazydev").setup {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    }
  end,
})
