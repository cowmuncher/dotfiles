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


-- Make background transparent (works in Kitty)
local groups = {
  "Normal", "NormalNC", "SignColumn", "NormalFloat", "VertSplit",
  "StatusLine", "TabLineFill", "Pmenu", "PmenuSbar", "PmenuThumb"
}

for _, g in ipairs(groups) do
  vim.api.nvim_set_hl(0, g, { bg = "none" })
end

-- Plugin manager
require("config.lazy")
