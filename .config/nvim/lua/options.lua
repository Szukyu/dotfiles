vim.g.mapleader = ' '
local opt = vim.opt

opt.clipboard = 'unnamedplus'
opt.completeopt = 'menuone,noselect,noinsert'
opt.conceallevel = 2
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
opt.foldlevel = 99
opt.ignorecase = true
opt.laststatus = 3
opt.linebreak = true
opt.mouse = 'a'
opt.number = true
opt.pumborder = 'rounded'
opt.pumheight = 15
opt.relativenumber = true
opt.shiftround = true
opt.shiftwidth = 2
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { 'en' }
opt.splitkeep = 'screen'
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = 'block'
opt.wildmode = 'longest:full,full'
opt.winborder = 'rounded'
opt.winminwidth = 5
opt.wrap = false

vim.o.statusline = " %f %m%h %= %l:%c | %L | %p%% "
vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

vim.lsp.enable({
	"lua_ls",
	"tailwindcss",
	"ts_ls",
})

require("vim._core.ui2").enable({})
