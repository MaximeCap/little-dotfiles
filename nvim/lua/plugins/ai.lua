return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      vendors = {
        ["taslgpt"] = {
          __inherit_from = "openai",
          endpoint = "http://localhost:11434/v1/chat/completions",
          model = "",
          api_key_name = "",
          disable_tools = true,
        },
      },
      mappings = {
        ask = "<leader>ac",
      },
      -- add any opts here
      -- for example
      provider = "copilot",
      file_selector = { provider = "snacks" },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "milanglacier/minuet-ai.nvim",
    enabled = function()
      local isThales = vim.fn.getenv("IS_THALES")

      if isThales == "true" then
        return true
      else
        return false
      end
    end,
    config = function()
      require("minuet").setup({
        -- Your configuration options here
        virtualtext = {
          auto_trigger_ft = { "*" },
          keymap = {
            accept = "<C-CR>",
            accept_line = "<C-TAB>",
            -- Cycle to prev completion item, or manually invoke completion
            prev = "<C-h>",
            -- Cycle to next completion item, or manually invoke completion
            next = "<C-l>",
            dismiss = "<A-e>",
          },
        },
        notify = false,
        provider = "openai_fim_compatible",
        provider_options = {
          openai_fim_compatible = {
            model = "qwen2.5-coder:1.5b-base",
            end_point = "http://localhost:11434/v1/completions",
            name = "Ollama",
            stream = true,
            api_key = "IS_THALES",
            optional = {
              stop = nil,
              max_tokens = nil,
            },
          },
        },
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local isThales = vim.fn.getenv("IS_THALES")

      local adapterToUse = "copilot"
      if isThales == "true" then
        adapterToUse = "ollama"
      end

      require("codecompanion").setup({
        display = {
          show_settings = true,
          chat = {
            diff = {
              provider = "mini_diff", -- default|mini_diff
            },
          },
        },
        strategies = {
          chat = {
            adapter = adapterToUse,
          },
          inline = {
            adapter = adapterToUse,
          },
        },
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "http://localhost:11434",
                --api_key = "OpenAI_API_KEY", -- optional: if your endpoint is authenticated
                chat_url = "/v1/chat/completions", -- optional: default value, override if different
              },
              schema = {
                model = {
                  default = "llama3.1:8b",
                },
              },
            })
          end,
        },
      })
    end,
  },
}
