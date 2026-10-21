-- Basic settings
vim.opt.termguicolors = true
vim.o.number = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Syntax highlightning and filetype plugins
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')


-- Plugin manager
require("config.lazy")
