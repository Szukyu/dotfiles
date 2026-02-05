-- Leader
vim.g.mapleader = " "

local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true
opt.expandtab = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.ignorecase = true
opt.shiftround = true
opt.shiftwidth = 2
opt.showmode = false
opt.signcolumn = "yes"
opt.tabstop = 2
opt.termguicolors = true

-- Keymaps Silent By Default
local keymap_set = vim.keymap.set
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
