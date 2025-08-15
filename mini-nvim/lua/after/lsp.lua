local M = {}

function M.setup()
	vim.pack.add({
		{ src = 'https://github.com/neovim/nvim-lspconfig' },
		{ src = "https://github.com/mason-org/mason.nvim" },
		{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
		{ src = 'https://github.com/stevearc/conform.nvim' }
	})

	require "mason".setup()
	require "mason-lspconfig".setup {
		ensure_installed = { "lua_ls", "gopls" }
	}

	vim.lsp.config("lua_ls", {
		on_init = function(client)
			local path = client.workspace_folders[1].name
			if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
				return
			end

			client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
				runtime = {
					-- Tell the language server which version of Lua you're using
					-- (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT'
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME
						-- Depending on the usage, you might want to add additional paths here.
						-- "${3rd}/luv/library"
						-- "${3rd}/busted/library",
					}
					-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
					-- library = vim.api.nvim_get_runtime_file("", true)
				}
			})
		end,
		settings = {
			Lua = {}
		}
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client ~= nil and client:supports_method('textDocument/completion') then
				vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			end
		end
	})

	vim.cmd("set completeopt+=noselect")

	require "conform".setup({
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback"
		}
	})
end

return M
