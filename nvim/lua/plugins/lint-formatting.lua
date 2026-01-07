return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile", "BufWritePost" },
		config = function()
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					-- try_lint without arguments runs the linters defined in `linters_by_ft`
					-- for the current filetype
					require("lint").try_lint()
				end,
			})
			require("lint").linters_by_ft = {
				markdown = { "markdownlint-cli2" },
			}
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = "ConformInfo",
		opts = {
			["markdownlint-cli2"] = {
				condition = function(_, ctx)
					local diag = vim.tbl_filter(function(d)
						return d.source == "markdownlint"
					end, vim.diagnostic.get(ctx.buf))
					return #diag > 0
				end,
			},
			format_on_save = {
				timeout_ms = 300,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", "biome", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", "biome", stop_after_first = true },
				typescript = { "prettierd", "prettier", "biome", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", "biome", stop_after_first = true },
				graphql = { "prettierd", "prettier", stop_after_first = true },
				sql = { "sql_formatter" },
				go = { "goimports", "gofmt" },
				markdown = { "prettierd", "prettier", "markdownlint-cli2" },
				python = { "ruff" },
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "xml" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
