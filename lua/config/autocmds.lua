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
