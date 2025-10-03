return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  },
  event = { "InsertEnter", "CmdLineEnter" },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      sources = cmp.config.sources({
        {
          name = 'buffer' ,
        },
        { 
          name = 'path',
          pathMappings = {
            ['@'] = '${folder}/src'
          },
        },
      }),
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
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
