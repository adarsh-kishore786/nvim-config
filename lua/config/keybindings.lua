-- Save
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', {desc = 'Save from normal mode'})
vim.keymap.set('i', '<C-s>', '<esc><cmd>w<CR>', {desc = 'Save from insert mode'})

-- Search highlighter
vim.keymap.set('n', '<esc><esc>', '<cmd>nohlsearch<CR>', {desc = 'Remove highlighting'})

-- Disable mouse
vim.opt.mouse = ""

-- Close
vim.keymap.set('n', '<leader>q', '<cmd>q!<CR>', { desc = 'Force close' })
vim.keymap.set('n', '<leader>x', '<cmd>x<CR>', { desc = 'Save and close' })

-- Some remaps
vim.keymap.set("n", "0", "^")
vim.keymap.set("n", "^", "0")
