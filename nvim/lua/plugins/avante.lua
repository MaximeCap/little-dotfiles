local ensure = require("config.lazy").loader({
  "https://github.com/HakonHarnes/img-clip.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/yetone/avante.nvim",
}, function()
  require("img-clip").setup {
    default = {
      embed_image_as_base64 = false,
      prompt_for_file_name = false,
      drag_and_drop = {
        insert_mode = true,
      },
      -- required for Windows users
      use_absolute_path = true,
    },
  }

  require("avante").setup {
    provider = "codex",
    acp_providers = {
      ["codex"] = {
        command = "npx",
        args = { "@zed-industries/codex-acp" },
        env = {
          NODE_NO_WARNINGS = "1",
          OPENAI_API_KEY = os.getenv "OPENAI_API_KEY",
        },
      },
    },
    providers = {
      openai = {
        endpoint = "http://localhost:8080/openai/v1",
        model = "gpt-5.4-mini",
      },
      claude = {
        auth_type = "pro",
      },
    },
    selector = {
      provider = "snacks",
      provider_opts = {},
    },
    input = {
      provider = "snacks",
      provider_opts = {
        title = "Avante Input",
        icon = " ",
      },
    },
  }
end)

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = vim.api.nvim_create_augroup("lazy_avante", { clear = true }),
  once = true,
  callback = ensure,
})
