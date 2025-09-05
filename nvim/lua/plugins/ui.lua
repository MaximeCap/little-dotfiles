local M = {}

-- local theme_file_path = vim.fn.expand("$HOME/.theme")
-- local uv = vim.uv
--
--
-- local function read_file(path)
-- 	local file = io.open(path, "r")
-- 	if not file then
-- 		return "dark"
-- 	end
-- 	local content = file:read("*line")
-- 	file:close()
-- 	return content
-- end
--
--
-- local function set_light()
-- 	vim.o.background = "light"
-- end
--
-- local function set_dark()
-- 	vim.o.background = "dark"
-- end
--
-- local function watch_theme_change()
-- 	local handle = uv.new_fs_event()
--
-- 	local unwatch_cb = function()
-- 		if handle then
-- 			uv.fs_event_stop(handle)
-- 		end
-- 	end
--
-- 	local event_cb = function(err)
-- 		if err then
-- 			error("Theme file watcher failed")
-- 			unwatch_cb()
-- 		else
-- 			vim.schedule(function()
-- 				local theme = read_file(theme_file_path)
-- 				if theme == "light" then
-- 					set_light()
-- 				else
-- 					set_dark()
-- 				end
-- 				unwatch_cb()
-- 				watch_theme_change()
-- 			end)
-- 		end
-- 	end
--
-- 	local flags = {
-- 		watch_entry = false,
-- 		stat = false,
-- 		recursive = false
-- 	}
--
-- 	if handle then
-- 		uv.fs_event_start(handle, theme_file_path, flags, event_cb)
-- 	end
--
-- 	return handle
-- end
--
-- local theme = read_file(theme_file_path)
-- watch_theme_change()

function M.setup()
	vim.pack.add({
		--{ src = "https://github.com/rktjmp/fwatch.nvim" },
		{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
		{ src = "https://github.com/lewis6991/gitsigns.nvim" },
		{ src = "https://github.com/nvim-lualine/lualine.nvim" }
	})

	require "gruvbox".setup {}

	require "lualine".setup({
		sections = {
			lualine_x = {
				-- {
				-- 	require "minuet.lualine",
				-- 	display_name = 'provider',
				-- 	display_on_idle = true
				-- },
				'encoding',
				'fileformat',
				'filetype'
			}
		}
	})

	--vim.o.background = theme

	vim.cmd("colorscheme gruvbox")
end

return M
