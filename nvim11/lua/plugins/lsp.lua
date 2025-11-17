return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/snacks.nvim",
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"lua_ls",
					"tailwindcss-language-server",
					"ts_ls",
					"gopls",
					"harper-ls",
					"markdownlint-cli2",
					"prettierd",
				},
				auto_update = false,
				run_on_start = true,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local Snacks = require("snacks")
					vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })
					vim.keymap.set("n", "<leader>cr", ":lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
					vim.keymap.set("n", "gd", function()
						Snacks.picker.lsp_definitions()
					end, { desc = "Goto Definition" })
					vim.keymap.set("n", "gD", function()
						Snacks.picker.lsp_declarations()
					end, { desc = "Goto Declaration" })
					vim.keymap.set("n", "gr", function()
						Snacks.picker.lsp_references()
					end, { nowait = true, desc = "References" })
					vim.keymap.set("n", "gI", function()
						Snacks.picker.lsp_implementations()
					end, { desc = "Goto Implementation" })
					vim.keymap.set("n", "gy", function()
						Snacks.picker.lsp_type_definitions()
					end, { desc = "Goto T[y]pe Definition" })
					vim.keymap.set("n", "<leader>ss", function()
						Snacks.picker.lsp_symbols()
					end, { desc = "LSP Symbols" })
					vim.keymap.set("n", "<leader>sS", function()
						Snacks.picker.lsp_workspace_symbols()
					end, { desc = "LSP Workspace Symbols" })

					vim.keymap.set("n", "gK", function()
						local new_config = not vim.diagnostic.config().virtual_lines
						vim.diagnostic.config({ virtual_lines = new_config })
					end, { desc = "Toggle diagnostic virtual_lines" })

					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- No need if we use Blink.cmp
					-- if client ~= nil and client:supports_method('textDocument/completion') then
					-- 	vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
					-- end

					if client ~= nil and client:supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
					end

					if client ~= nil and client.id == "helm_ls" then
						require("helm-ls").setup()
					end

					vim.keymap.set("n", "<leader>ch", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						print("Inlay hints : " .. tostring(vim.lsp.inlay_hint.is_enabled()))
					end)
				end,
			})

			-- vim.api.nvim_create_autocmd("LspProgress", {
			-- 	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
			-- 	callback = function(ev)
			-- 		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
			-- 		vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
			-- 			id = "lsp_progress",
			-- 			msg = ev.data.params.value.message,
			-- 			opts = function(notif)
			-- 				notif.icon = ev.data.params.value.kind == "end" and " "
			-- 					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			-- 			end,
			-- 		})
			-- 	end,
			-- })
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},
}
