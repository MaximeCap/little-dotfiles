local o = vim.o
o.number = true
o.relativenumber = true
o.autoindent = true -- Enable auto indentation
o.expandtab = true -- Use spaces instead of tabs
o.tabstop = 2 -- Number of spaces for a tab
o.softtabstop = 2 -- Number of spaces for a tab when editing
o.shiftwidth = 2 -- Number of spaces for autoindent
o.conceallevel = 2
o.termguicolors = true
o.undofile = true
o.swapfile = false
o.completeopt = "menuone,noselect,fuzzy,popup"
o.winborder = "rounded"
o.ignorecase = true
o.smartcase = true -- case-sensitive search if an uppercase char is typed
o.cmdheight = 1

-- TODO see the effect
o.cursorlineopt = "both" -- to enable cursorline!
o.inccommand = "split"
o.cursorline = true
o.textwidth = 100
-- o.listchars = "tab: ,multispace:|   ,space:·"
-- o.list = true
o.clipboard = "unnamedplus"

-- QoL
o.scrolloff = 8 -- keep 8 lines visible around the cursor
o.sidescrolloff = 8
o.signcolumn = "yes" -- always show the sign column (prevents text jitter)
o.splitright = true -- vertical splits open to the right
o.splitbelow = true -- horizontal splits open below
o.smoothscroll = true -- wrap-aware scrolling for <C-d>/<C-u> (0.10+)
o.wrap = false
o.linebreak = true -- if wrap is toggled on, break at word boundaries
o.breakindent = true -- wrapped lines preserve indentation
o.confirm = true -- prompt to save instead of failing on :q with unsaved changes
o.updatetime = 250 -- faster CursorHold & gitsigns blame
o.timeoutlen = 400 -- snappier leader chords
o.jumpoptions = "stack,view" -- saner jumplist behavior
o.virtualedit = "block" -- free-form movement in visual-block mode
