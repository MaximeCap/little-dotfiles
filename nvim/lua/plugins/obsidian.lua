vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  group = vim.api.nvim_create_augroup("lazy_obsidian", { clear = true }),
  once = true,
  callback = function()
    vim.pack.add { "https://github.com/obsidian-nvim/obsidian.nvim" }
    require("obsidian").setup {
      legacy_commands = false,
      workspaces = {
        { name = "personal", path = "~/vaults/personal" },
        { name = "work", path = "~/vaults/work" },
      },
    }
  end,
})
