return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    }
  },
  config = function()
    require('telescope').setup({
      defaults = {
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
  end,
}
