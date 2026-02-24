-- Enable 24-bit color
vim.opt.termguicolors = true

-- Make background transparent (works in Kitty)
local groups = {
  "Normal", "NormalNC", "SignColumn", "NormalFloat", "VertSplit",
  "StatusLine", "TabLineFill", "Pmenu", "PmenuSbar", "PmenuThumb"
}

for _, g in ipairs(groups) do
  vim.api.nvim_set_hl(0, g, { bg = "none" })
end

-- Example: set a colorscheme (optional)
-- vim.cmd("colorscheme gruvbox")

