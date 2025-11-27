return {
  "olimorris/codecompanion.nvim",

  strategies = {
    chat = { adapter = "openrouter" },
    inline = { adapter = "openrouter" },
    agent = { adapter = "openrouter" },  -- If using /agent commands
  },

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
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- Keymap to save the current chat manually (when auto_save is disabled)
            save_chat_keymap = "sc",
            -- Save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 0,
            -- Picker interface (auto resolved to a valid picker)
            picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default") 
            ---Optional filter function to control which chats are shown when browsing
            chat_filter = nil, -- function(chat_data) return boolean end
            -- Customize picker keymaps (optional)
            picker_keymaps = {
              rename = { n = "r", i = "<M-r>" },
              delete = { n = "d", i = "<M-d>" },
              duplicate = { n = "<C-y>", i = "<C-y>" },
            },
            ---Automatically generate titles for new chats
            auto_generate_title = true,
            title_generation_opts = {
              ---Adapter for generating titles (defaults to current chat adapter) 
              adapter = nil, -- "copilot"
              ---Model for generating titles (defaults to current chat model)
              model = nil, -- "gpt-4o"
              ---Number of user prompts after which to refresh the title (0 to disable)
              refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
              ---Maximum number of times to refresh the title (default: 3)
              max_refreshes = 3,
              format_title = function(original_title)
                -- this can be a custom function that applies some custom
                -- formatting to the title.
                return original_title
              end
            },
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = false,

            -- Summary system
            summary = {
              -- Keymap to generate summary for current chat (default: "gcs")
              create_summary_keymap = "gcs",
              -- Keymap to browse summaries (default: "gbs")
              browse_summaries_keymap = "gbs",
              generation_opts = {
                adapter = nil, -- defaults to current chat adapter
                model = nil, -- defaults to current chat model
                context_size = 90000, -- max tokens that the model supports
                include_references = true, -- include slash command content
                include_tool_outputs = true, -- include tool execution results
                system_prompt = nil, -- custom system prompt (string or function)
                format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
              },
            },
          }
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
    vim.keymap.set("n", "<leader>al", ":CodeCompanionChat Load<CR>", { desc = "Load CodeCompanion chat" })
  end,
}
