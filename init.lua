vim.cmd [[set encoding=UTF-8]]
vim.g.mapleader = ' '

require('config.lazy')

require('basic.numbers')
require('basic.appearance')
require('basic.search')
require('basic.indentation')
require('basic.statusline')

require('config.keybindings')
require('config.autocmds')
