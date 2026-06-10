-- require "nvchad.autocmds"
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  desc = "highlight selection on yank",
  callback = function()
    vim.highlight.on_yank { timeout = 200, visual = true }
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "K", vim.lsp.buf.hover, "LSP Hover")
    map("n", "gd", function()
      Snacks.picker.lsp_definitions()
    end, "Go to definition")
    map("n", "gD", function()
      Snacks.picker.lsp_declarations()
    end, "Go to declaration")
    map("n", "gi", function()
      Snacks.picker.lsp_implementations()
    end, "Go to implementation")
    map("n", "gr", function()
      Snacks.picker.lsp_references()
    end, "References")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>lf", function()
      vim.lsp.buf.format { async = true }
    end, "Format buffer (LSP)")

    -- Highlight references of the symbol under the cursor on CursorHold.
    -- Fires after `updatetime` ms (250ms in options.lua).
    if client and client:supports_method "textDocument/documentHighlight" then
      local hl_group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = hl_group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = hl_group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp_document_highlight_detach_" .. bufnr, { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.clear_references()
          pcall(vim.api.nvim_del_augroup_by_id, hl_group)
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    -- syntax highlighting, provided by Neovim
    pcall(vim.treesitter.start)
    -- folds, provided by Neovim
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.wo.foldenable = false
  end,
})

local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  group = group,
  once = true,
  callback = function()
    local opts = require "plugins.completion"
    require("blink.cmp").setup(opts)
  end,
})

-- -- Remove command line when not writing as command
-- vim.api.nvim_create_autocmd("CmdlineEnter", {
--   group = vim.api.nvim_create_augroup("gmr_cmdheight_1_on_cmdlineenter", { clear = true }),
--   desc = "Don't hide the status line when typing a command",
--   command = ":set cmdheight=1",
-- })
--
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
--   group = vim.api.nvim_create_augroup("gmr_cmdheight_0_on_cmdlineleave", { clear = true }),
--   desc = "Hide cmdline when not typing a command",
--   command = ":set cmdheight=0",
-- }e
