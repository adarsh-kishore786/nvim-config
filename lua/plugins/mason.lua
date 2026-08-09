return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig"
  },
  opts = {},
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_server_setup = true
    })

    vim.lsp.config('lua_ls', {
      settings = {
          Lua = {
              diagnostics = {
                globals = { "vim" },
              },
          },
      },
    })

    vim.lsp.config('racket_langserver', {
      cmd = { 'racket', '--lib', 'racket-langserver' },
      filetypes = { 'racket', 'scheme' },
      root_markers = { '.git' }
    })

    vim.lsp.enable('racket_langserver')
  end
}
