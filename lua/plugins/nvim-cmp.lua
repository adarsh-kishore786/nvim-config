return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  },
  event = { "InsertEnter", "CmdLineEnter" },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      sources = cmp.config.sources(
        {
          { name = "copilot" },
          { name = "nvim_lsp" },
        },
        {
          { name = "buffer" },
          { name = "path" }
        }),
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-c>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true })
      }),
      completion = { completeopt = 'menu,menuone' }
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      },
      completion = { completeopt = 'menu,menuone,noselect' }
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
          { name = 'cmdline' }
        }),
      completion = { completeopt = 'menu,menuone,noselect' }
    })
  end
}
