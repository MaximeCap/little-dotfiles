local M = {}

-- Returns an idempotent loader. First call runs vim.pack.add(pack) and the
-- optional setup() callback; subsequent calls are no-ops.
--   local ensure = require("config.lazy").loader(
--     { "https://github.com/folke/flash.nvim" },
--     function() require("flash").setup {} end
--   )
function M.loader(pack, setup)
  local loaded = false
  return function()
    if loaded then
      return
    end
    loaded = true
    if pack then
      vim.pack.add(pack)
    end
    if setup then
      setup()
    end
  end
end

return M
