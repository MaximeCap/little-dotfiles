local ensure = require("config.lazy").loader({
  "https://github.com/likec4/likec4.nvim",
}, function()
  if vim.fn.executable "likec4" == 0 then
    vim.notify("Installing likec4...", vim.log.levels.INFO)
    vim.fn.system { "npm", "install", "-g", "likec4" }
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to install likec4 — LSP will not start", vim.log.levels.WARN)
      return
    end
  end
  vim.lsp.enable "likec4"
end)

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = vim.api.nvim_create_augroup("lazy_likec4", { clear = true }),
  once = true,
  callback = ensure,
})
