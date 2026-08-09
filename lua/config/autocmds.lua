-- create new autocmd group
vim.api.nvim_create_augroup("config", { clear = true })

-- highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "config",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { timeout = 200 }
  end
})

-- cd nvim into the working directory
-- this causes Telescope to work in the cwd, not pwd
vim.api.nvim_create_autocmd("VimEnter", {
  group = "config",
  callback = function()
    local arg = vim.fn.argv(0)
    if type(arg) == "string" and vim.fn.isdirectory(arg) == 1 then
      vim.cmd.cd(arg)
    end
  end
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- Check if the LSP server supports document colors
    if client and client:supports_method('textDocument/documentColor') then
      vim.lsp.document_color.enable(true, args.buf)
    end
  end,
})
