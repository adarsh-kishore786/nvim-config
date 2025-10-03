return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",

  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { "c", "cpp", "rust", "lua", "java", "markdown" },
      highlight = { enable = true },
      indent = { enable = true }
    })

    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

    vim.cmd("set nofoldenable")
  end
}
