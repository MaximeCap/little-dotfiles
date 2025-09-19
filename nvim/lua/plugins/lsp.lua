local M = {}

function M.setup()
	vim.pack.add({
		{ src = 'https://github.com/neovim/nvim-lspconfig' },
		{ src = "https://github.com/mason-org/mason.nvim" },
		{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
		{ src = 'https://github.com/stevearc/conform.nvim' },
		{ src = 'https://github.com/j-hui/fidget.nvim' },
		{ src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
		{ src = 'https://github.com/qvalentin/helm-ls.nvim' }
	})

	require "fidget".setup()

	-- Install LSP
	require "mason".setup()
	require "mason-lspconfig".setup {}

	require('mason-tool-installer').setup {
		ensure_installed = {
			"kube-linter",
			"docker-language-server",
			"yamlls",
			"helm_ls",
			"lua_ls",
			"gopls",
			"vtsls",
			"tailwindcss",
			"eslint",
			"prettier"
		}
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

	vim.lsp.config("vtsls", {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		settings = {
			typescript = {
				updateImportsOnFileMove = { enabled = "always" },
				suggest = {
					completeFunctionCalls = true,
				},
				inlayHints = {
					enumMemberValues = { enabled = true },
					functionLikeReturnTypes = { enabled = true },
					parameterNames = { enabled = "literals" },
					parameterTypes = { enabled = true },
					propertyDeclarationTypes = { enabled = true },
					variableTypes = { enabled = false },
				},
			},
		}
	})


	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			local Snacks = require "snacks"
			vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })
			vim.keymap.set("n", "<leader>cr", ":lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
			vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
			vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
			vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end,
				{ nowait = true, desc = "References" })
			vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
			vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
			vim.keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
			vim.keymap.set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,
				{ desc = "LSP Workspace Symbols" })

			vim.keymap.set('n', 'gK', function()
				local new_config = not vim.diagnostic.config().virtual_lines
				vim.diagnostic.config({ virtual_lines = new_config })
			end, { desc = 'Toggle diagnostic virtual_lines' })

			local client = vim.lsp.get_client_by_id(ev.data.client_id)

			-- No need if we use Blink.cmp
			-- if client ~= nil and client:supports_method('textDocument/completion') then
			-- 	vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			-- end

			if client ~= nil and client:supports_method('textDocument/inlayHint') then
				vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
			end

			if client ~= nil and client.id == "helm_ls" then
				require "helm-ls".setup()
			end

			--require "lsp_signature".setup({}, ev.buf)
		end
	})

	require 'blink.cmp'.setup({
		keymap = {
			['<A-y>'] = require "minuet".make_blink_map()
		},
		sources = {
			default = { 'lsp', 'path', 'buffer', 'snippets' },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
		signature = { enabled = true },
		completion = {
			trigger = {
				prefetch_on_insert = false
			},
			menu = {
				auto_show = true,
				draw = {
					treesitter = { "lsp" },
					columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } }
				}
			}
		}
	})

	--  Autoformat
	require "conform".setup({
		formatters_by_ft = {
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			yaml = { "prettier" }
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback"
		}
	})

	vim.keymap.set("n", "<leader>ch", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		print("Inlay hints : " .. tostring(vim.lsp.inlay_hint.is_enabled()))
	end)
end

return M
