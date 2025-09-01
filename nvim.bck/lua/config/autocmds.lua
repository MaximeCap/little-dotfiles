-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
---
---- ~/.config/nvim/lua/config/autocmds.lua
-- Add this to your existing autocmds.lua file or create it if it doesn't exist

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Hugo HTML Template Detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("hugo_html_template"),
  pattern = "*.gohtml",
  callback = function()
    print("GoHtml detected")
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    -- Check if the file contains Hugo template syntax
    for _, line in ipairs(lines) do
      if string.match(line, "{{.*}}") then
        vim.bo.filetype = "gohtmltmpl"
        break
      end
    end
  end,
  desc = "Detect Hugo HTML templates and set filetype to gohtmltmpl",
})
