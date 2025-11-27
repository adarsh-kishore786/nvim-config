return {
  "olimorris/codecompanion.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
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
      strategies = {
        chat = { adapter = "openrouter" },
        inline = { adapter = "openrouter" },
        agent = { adapter = "openrouter" },
      },
      opts = {
        log_level = "DEBUG",
      },

      display = {
        chat = {
          window = {
            layout = "vertical",
            position = "right",
            width = 0.3
          },
        }
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "sc",
            auto_save = true,
            expiration_days = 0,
            picker = "telescope",
            chat_filter = nil,
            picker_keymaps = {
              rename = { n = "r", i = "<M-r>" },
              delete = { n = "d", i = "<M-d>" },
              duplicate = { n = "<C-y>", i = "<C-y>" },
            },
            auto_generate_title = true,
            title_generation_opts = {
              adapter = "openrouter",
              model = nil,
              refresh_every_n_prompts = 0,
              max_refreshes = 3,
            },
            continue_last_chat = false,
            delete_on_clearing_chat = false,
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            enable_logging = false,

            summary = {
              create_summary_keymap = "gcs",
              browse_summaries_keymap = "gbs",
              generation_opts = {
                adapter = nil,
                model = nil,
                context_size = 90000,
                include_references = true,
                include_tool_outputs = true,
                system_prompt = nil,
                format_summary = nil,
              },
            },
          }
        }
      },
      adapters = {
        http = {
          opts = {
            timeout = 30000,
          },
          openrouter = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "OpenRouter",
              env = {
                url = "https://openrouter.ai/api",
                api_key = "OPENROUTER_API_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "z-ai/glm-4.5-air:free",
                },
                temperature = { default = 0.7 },
                max_tokens = { default = 4096 },
              },
              headers = {
                ["HTTP-Referer"] = "https://github.com",
                ["X-Title"] = "CodeCompanion.nvim",
              },
            })
          end,
        },
      },
    })

    vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat<CR>", { desc = "OpenRouter Chat" })
    vim.keymap.set("n", "<leader>al", ":CodeCompanionChat Load<CR>", { desc = "Load CodeCompanion chat" })
  end,
}
