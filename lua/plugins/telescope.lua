return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--follow",        -- Follow symbolic links
          "--hidden",        -- Search for hidden files
          "--no-heading",    -- Don't group matches by each file
          "--no-ignore",     -- Don't respect .gitignore or .ignore files
          "--with-filename", -- Print the file path with the matched lines
          "--line-number",   -- Show line numbers
          "--column",        -- Show column numbers
          "--smart-case",    -- Smart case search

          -- Exclude some patterns from search
          "--glob=!**/.git/*",
          "--glob=!**/.idea/*",
          "--glob=!**/.vscode/*",
          "--glob=!**/build/*",
          "--glob=!**/dist/*",
          "--glob=!**/yarn.lock",
          "--glob=!**/package-lock.json",
          "-g", "!*.{png,jpg,gif,pdf,exe,bin,o,so,dylib,zip,tar,gz}",
        },
        mappings = {
          i = {
            -- Insert mode mappings
            ["<esc>"] = require("telescope.actions").close,
          },
          n = {
            -- Normal mode mappings
            ["<esc>"] = require("telescope.actions").close,
            ["q"] = require("telescope.actions").close,
          },
        },
        layout_config = {
          horizontal = {
            preview_width = 0.4,
          },
        },
      },
      -- Move pickers OUTSIDE of defaults, at the same level
      pickers = {
        find_files = {
          hidden = true,
          -- needed to exclude some files & dirs from general search
          -- when not included or specified in .gitignore
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--no-ignore",
            "--no-binary",
            "--glob=!**/.git/*",
            "--glob=!**/.idea/*",
            "--glob=!**/.vscode/*",
            "--glob=!**/build/*",
            "--glob=!**/dist/*",
            "--glob=!**/yarn.lock",
            "--glob=!**/package-lock.json",
            "-g", "!*.{png,jpg,gif,pdf,exe,bin,o,so,dylib,zip,tar,gz}",
          },
        },
      },
    })

    require('telescope').load_extension('fzf')

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope recent files' })
    vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Telescope commands' })
    vim.keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, { desc = 'Telescope current buffer fuzzy find' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })

    -- Current buffer only
    vim.keymap.set('n', '<leader>fD', function()
      builtin.diagnostics({ bufnr = 0 })
    end, { desc = 'Current buffer diagnostics' })

    -- Only errors
    vim.keymap.set('n', '<leader>fe', function()
      builtin.diagnostics({ severity = 'ERROR' })
    end, { desc = 'Errors only' })
  end,
}
