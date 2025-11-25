return {
  "olimorris/codecompanion.nvim",

  strategies = {
    chat = { adapter = "openrouter" },
    inline = { adapter = "openrouter" },
    agent = { adapter = "openrouter" },  -- If using /agent commands
  },

  opts = {
    log_level = "INFO",  -- Set to "DEBUG" for troubleshooting
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" }
    },

    {
      "echasnovski/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
  },
  config = function()
    -- Guard for API key
    if not vim.env.OPENROUTER_API_KEY or vim.env.OPENROUTER_API_KEY == "" then
      vim.notify("OPENROUTER_API_KEY not set! Export it in your shell config.", vim.log.levels.ERROR)
      return
    end

    require("codecompanion").setup({
      display = {
        chat = {
          window = {
            layout = "vertical",
            position = "right",
            width = 0.3
          },
        }
      },
      adapters = {
        http = {
          opts = {
            timeout = 30000,  -- Global HTTP timeout
          },
          openrouter = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "OpenRouter",
              env = {
                url = "https://openrouter.ai/api",
                api_key = "OPENROUTER_API_KEY",  -- Pulls from env
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "z-ai/glm-4.5-air:free",
                },
                temperature = { default = 0.7 },
                max_tokens = { default = 4096 },
              },
            })
          end,
        },
      },
    })

    vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat<CR>", { desc = "OpenRouter Chat" })
  end,
}
