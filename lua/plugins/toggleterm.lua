function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      local toggleTerm = require("toggleterm")
      toggleTerm.setup({
        direction = "horizontal",
        open_mapping = [[<C-\>]],
        shade_terminals = false,
        close_on_exit = true,
        float_opts = {
          border = "single",
          insert_mappings = false,
          highlights = {
            border = "FloatBorder",
          },
        },
      })
      local terms = require("toggleterm.terminal")
      local function get_next_term_num()
        local all = terms.get_all(true)
        if #all == 0 then
          return 1
        end
        local last = all[#all].id
        return last + 1
      end
      local function get_count(params)
        if params.count ~= 0 then
          return params.count
        end
        return get_next_term_num()
      end
      vim.api.nvim_create_user_command("Run", function(params)
        toggleTerm.exec("exec " .. params.args, get_count(params))
      end, {
          nargs = "*",
          complete = "shellcmd",
          count = 0,
        })
      vim.api.nvim_create_user_command("RunWait", function(params)
        toggleTerm.exec(
          params.args .. [[ ; echo && echo && read -n 1 -s -p "[Press key to continue]" && exec true]],
          get_count(params)
        )
      end, {
          nargs = "*",
          complete = "shellcmd",
          count = 0,
        })
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end
  }
}
