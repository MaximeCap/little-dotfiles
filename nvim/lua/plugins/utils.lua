return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "~/.local/share/nvim/lazy/",
      },
    },
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    enabled = false,
    event = "VeryLazy",
    opts = {
      -- your options here
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup({
        options = {
          throttle = 0,
          enable_on_insert = true,
          show_all_diags_on_cursorline = true,
          show_source = {
            enabled = true,
          },
          virt_texts = {
            priority = 8192,
          },
        },
      })
      -- vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
  },
  {
    "hakonharnes/img-clip.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>p",
        "<cmd>PasteImage<cr>",
        desc = "Past image from system clipboard",
      },
    },
  },
  {
    "3rd/image.nvim",
    enabled = false,
    opts = {
      integrations = {
        markdown = {
          only_render_image_at_cursor = true,
        },
      },
      tmux_show_only_in_active_window = true,
    },
  },
}
