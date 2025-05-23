return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    enabled = false,
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
  {
    "milanglacier/minuet-ai.nvim",
    enabled = function()
      local isThales = vim.fn.getenv("COPILOT")

      if isThales == "ollama" then
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
            accept = "<M-C-Y>",
            accept_line = "<M-C-S-Y>",
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
}
