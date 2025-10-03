return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    
    wk.setup({
      -- Show keys as you type them
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,    -- Show operator pending keystrokes (d, y, c, etc.)
          motions = true,      -- Show motion keystrokes (w, b, e, etc.)
          text_objects = true, -- Show text object keystrokes (iw, i", etc.)
          windows = true,      -- Show window commands (ctrl+w)
          nav = true,          -- Show navigation commands
          z = true,            -- Show z commands
          g = true,            -- Show g commands
        },
      },
      -- Visual settings for the popup
      win = {
        border = "rounded",
        padding = { 1, 2 },
      },
      
      -- Show incomplete keymaps
      show_help = true,
      show_keys = true,
      
      -- Trigger which-key on these keys
      triggers = {
        { "<auto>", mode = "nixsotc" },  -- Auto-trigger on all modes
      },
    })
  end,
}
