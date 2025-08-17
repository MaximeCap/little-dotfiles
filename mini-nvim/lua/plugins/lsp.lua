local M = {}

function M.setup()
	vim.pack.add({
		{ src = 'https://github.com/neovim/nvim-lspconfig' },
		{ src = "https://github.com/mason-org/mason.nvim" },
		{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
		{ src = 'https://github.com/stevearc/conform.nvim' },
		{ src = 'https://github.com/j-hui/fidget.nvim' }
	})

	require "fidget".setup()

	-- Install LSP
	require "mason".setup()
	require "mason-lspconfig".setup {
		ensure_installed = { "lua_ls", "gopls", "ts_ls" }
	}

	-- Remove warning with global variable vim
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
			Lua = {
				hint = {
					enable = true
				}
			}
		}
	})

	vim.lsp.config("gopls", {
		settings = {
			gopls = {
				["inlayHints.hints"] = {
					parameterNames = true
				}
			}
		}

	})

	-- vim.lsp.config("*", {
	-- 	capabilities = {
	-- 		textDocument = {
	-- 			inlayHint = true
	-- 		}
	-- 	}
	-- })

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client ~= nil and client:supports_method('textDocument/completion') then
				vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			end

			if client ~= nil and client:supports_method('textDocument/inlayHint') then
				vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
			end
		end
	})

	vim.cmd("set completeopt+=noselect")

	--  Autoformat
	require "conform".setup({
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback"
		}
	})
end

return M
