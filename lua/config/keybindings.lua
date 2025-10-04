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

-- shift buffers
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })

 -- create and cycle splits
vim.keymap.set('n', '<leader>-', '<cmd>split<CR>', { desc = "Create horizontal split" })
vim.keymap.set('n', '<leader>|', '<cmd>vsplit<CR>', { desc = "Create vertical split" })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Go to left split" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Go to down split" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Go to up split" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Go to right split" })

-- increase/decrease buffer sizes
vim.keymap.set('n', '=', '<C-w>+', { desc = "Increase height" })
vim.keymap.set('n', '-', '<C-w>-', { desc = "Decrease height" })
vim.keymap.set('n', '_', '<C-w><', { desc = "Decrease width" })
vim.keymap.set('n', '+', '<C-w>>', { desc = "Increase width" })
