return {
	{
		"milanglacier/minuet-ai.nvim",
		keys = {
			{
				"<leader>at",
				"<CMD>Minuet virtualtext toggle<CR>",
				desc = "Toggle Minuet Virtualtext",
			},
		},
		config = function()
			require("minuet").setup({
				auto_trigger_ft = { "*" },
				provider = "openai_fim_compatible",
				provider_options = {
					openai_fim_compatible = {
						model = "qwen2.5-coder:1.5b-base",
						end_point = "http://localhost:11434/v1/completions",
						name = "Qwen",
						api_key = function()
							return "text"
						end,
						stream = true,
					},
				},
				virtualtext = {
					show_on_completion_menu = true,
					keymap = {
						accept = "<A-y>",
						accept_line = "<A-e>",
						prev = "<A-[>",
						next = "<A-]>",
					},
				},
			})
		end,
	},
}
