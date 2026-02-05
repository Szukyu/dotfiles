-- Leader
vim.g.mapleader = " "

-- Tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.swapfile = false

-- Terminal GUI Color
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- Copy to System Clipboard
vim.cmd("set clipboard+=unnamedplus")

-- Keymaps Silent By Default
local keymap_set = vim.keymap.set
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

-- FZF
vim.env.FZF_DEFAULT_OPTS = ""

-- Completion
vim.opt.completeopt = "menuone,noselect"

vim.opt.conceallevel = 0


































