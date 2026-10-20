-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  {
    "bluz71/vim-moonfly-colors",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme moonfly")
    end,
  },
  {
    -- File explorer + fuzzy pickers (Helix-style <space> workflow)
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
      -- `nvim .` / `nvim some/dir` opens the explorer instead of netrw
      explorer = { replace_netrw = true },
      picker = {
        sources = {
          explorer = { hidden = true, auto_close = false },
          files = { hidden = true },
          grep = { hidden = true },
        },
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          -- Focus the explorer if it is open, otherwise open it
          local explorer = Snacks.picker.get({ source = "explorer" })[1]
          if explorer then explorer:focus() else Snacks.explorer() end
        end,
        desc = "File explorer (open/focus)",
      },
      { "<C-h>", "<C-w>h", desc = "Window left" },
      { "<C-l>", "<C-w>l", desc = "Window right" },
      { "<leader>f", function() Snacks.picker.files() end, desc = "Find file" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep project" },
      { "<leader>*", function() Snacks.picker.grep_word() end, desc = "Grep word", mode = { "n", "x" } },
      { "<leader>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>r", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<leader>'", function() Snacks.picker.resume() end, desc = "Resume last picker" },
      { "<leader>g", function() Snacks.picker.git_status() end, desc = "Changed files (git)" },
      { "<leader>s", function() Snacks.picker.lsp_symbols() end, desc = "Document symbols" },
      { "<leader>S", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },
      { "<leader>d", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostics (buffer)" },
      { "<leader>D", function() Snacks.picker.diagnostics() end, desc = "Diagnostics (workspace)" },
      { "<leader>?", function() Snacks.picker.keymaps() end, desc = "Search keymaps" },
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto definition" },
    },
  },
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {},
  },
  {
    -- Popup showing available keys after <space>, like Helix
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { preset = "helix" },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config('clangd', {})
      vim.lsp.enable('clangd')
    end,
  },
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = { "L3MON4D3/LuaSnip" },
    opts = {
      keymap = { preset = "super-tab" },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "evesdropper/luasnip-latex-snippets.nvim",
    ft = { "tex", "markdown" },
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require("luasnip-latex-snippets")
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "^4.0.0",
    event = "VeryLazy",
  }
})
