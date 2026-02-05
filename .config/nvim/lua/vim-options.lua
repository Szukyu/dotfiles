vim.g.mapleader = " "

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- Copy to System Clipboard
vim.cmd("set clipboard+=unnamedplus")

-- Key Maps
vim.keymap.set("n", "<leader>l", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Tab"})
vim.keymap.set("n", "<leader>h", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous Tab"})









































