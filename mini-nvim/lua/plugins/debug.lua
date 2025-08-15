local M = {}

function M.setup()
	vim.pack.add({
		{ src = "https://github.com/nvim-neotest/nvim-nio" },
		{ src = "https://github.com/rcarriga/nvim-dap-ui" },
		{ src = "https://github.com/mfussenegger/nvim-dap" },
		{ src = 'https://github.com/jay-babu/mason-nvim-dap.nvim' },
		{ src = 'https://github.com/leoluz/nvim-dap-go' },

	})

	local dap, dapui = require("dap"), require("dapui")
	dapui.setup()

	require "mason".setup()
	require "mason-nvim-dap".setup {
		ensure_installed = { "delve" }
	}

	require('dap-go').setup()


	-- Keymap setting
	local keys = vim.keymap

	keys.set("n", "<leader>db", function() dap.toggle_breakpoint() end)
	keys.set("n", "<leader>dc", function() dap.continue() end)
	keys.set("n", "<leader>dt", function() dap.terminate() end)

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open({ reset = true })
	end
end

return M
