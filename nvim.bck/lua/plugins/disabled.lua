return {
  {
    "folke/noice.nvim",
    enabled = false,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   enabled = vim.env.IS_THALES ~= "true",
  -- },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = vim.env.IS_THALES ~= "true",
  },
}
