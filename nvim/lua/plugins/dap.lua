local ensure = require("config.lazy").loader({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/igorlfs/nvim-dap-view",
  "https://github.com/leoluz/nvim-dap-go",
  "https://github.com/mfussenegger/nvim-dap-python",
}, function()
  require("dap-view").setup {}
  require("dap-go").setup {
    dap_configurations = {
      {
        type = "go",
        name = "Attach remote",
        mode = "remote",
        request = "attach",
        host = "127.0.0.1",
        port = 38697,
      },
    },
  }
  require("dap-python").setup "uv"
end)

local km = vim.keymap
km.set("n", "<leader>db", function()
  ensure()
  vim.cmd "DapToggleBreakpoint"
end, { desc = "Toggle Breakpoint" })
km.set("n", "<leader>dc", function()
  ensure()
  vim.cmd "DapContinue"
end, { desc = "Continue" })
km.set("n", "<leader>dgo", function()
  ensure()
  vim.cmd "DapStepOver"
end, { desc = "Step over" })
km.set("n", "<leader>dgi", function()
  ensure()
  vim.cmd "DapStepInto"
end, { desc = "Step into" })
km.set("n", "<leader>du", function()
  ensure()
  vim.cmd "DapViewToggle"
end, { desc = "Toggle DapView" })
km.set("n", "<leader>dpt", function()
  ensure()
  require("dap-python").test_method()
end, { desc = "Python Test method" })
km.set("n", "<leader>dpc", function()
  ensure()
  require("dap-python").test_class()
end, { desc = "Python Test class" })
km.set("v", "<leader>dps", function()
  ensure()
  require("dap-python").debug_selection()
end, { desc = "Python Test selection" })
