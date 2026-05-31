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
