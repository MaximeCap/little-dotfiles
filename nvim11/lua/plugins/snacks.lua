return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>f",
      function()
        require("snacks").picker.smart()
      end,
    },
    {
      "<leader>/",
      function()
        require("snacks").picker.grep()
      end,
    },
    {
      "<leader><leader>",
      function()
        require("snacks").picker.smart()
      end,
    },
    {
      "<leader>gg",
      function()
        require("snacks").lazygit()
      end,
    },
  },
  opts = {
    picker = { enable = true },
    input = { enable = true },
    lazygit = { enable = true },
  },
  config = true,
}
