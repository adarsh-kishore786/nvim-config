return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,           -- don't lazy-load; it needs to attach on startup
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional but makes device picker nicer
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          border = "rounded",
          notification_style = "native",
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,    -- shows active device in statusline
          },
        },
        flutter_path = nil,   -- auto-detected; set explicitly if needed
        -- e.g. flutter_path = "/home/you/flutter/bin/flutter",
        flutter_lookup_cmd = nil,
        fvm = false,          -- set true if you use fvm
        widget_guides = {
          enabled = false,    -- virtual text guides; try it, many find it noisy
        },
        closing_tags = {
          highlight = "ErrorMsg",
          prefix = "// ",
          enabled = true,     -- shows closing tag hints for widget trees
        },
        dev_log = {
          enabled = true,
          open_cmd = "tabedit",   -- or "15split" if you prefer a split
        },
        lsp = {
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = {
              vim.fn.expand("$HOME/flutter/"),  -- stop it analysing the SDK
            },
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
          },
          -- on_attach = function(client, bufnr)
          --   -- put your standard LSP keymaps here, e.g.:
          --   local opts = { buffer = bufnr, silent = true }
          --   vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          --   vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
          --   vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          --   vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          --   vim.keymap.set("n", "<leader>f",  vim.lsp.buf.format, opts)
          -- end,
        },
        debugger = {
          enabled = false,    -- set true only if you've configured nvim-dap
          run_via_dap = false,
        },
      })
    end,
  },
}
