local M = {}

function M.setup()
	local minuet = require "minuet"
	-- minuet.setup {
	-- 	virtualtext = {
	-- 		auto_trigger_ft = { '*' },
	-- 		keymap = {
	-- 			accept = "<A-A>",
	-- 			accept_line = "<A-a>",
	-- 			prev = "<A-[>",
	-- 			next = "<A-]>",
	-- 			dismiss = "<A-e>"
	-- 		}
	-- 	},
	-- 	provider = "openai_fim_compatible",
	-- 	notify = "debug",
	-- 	provider_options = {
	-- 		openai_fim_compatible = {
	-- 			model = 'qwen2.5-coder:1.5b-base',
	-- 			stream = false,
	-- 			end_point = 'http://localhost:11434/v1/completions',
	-- 			api_key = 'TERM',
	-- 			name = 'Qwen ✨',
	-- 			optional = {
	-- 				stop = nil,
	-- 				max_tokens = nil,
	-- 			},
	-- 		}
	-- 	}
	-- }
end

return M
