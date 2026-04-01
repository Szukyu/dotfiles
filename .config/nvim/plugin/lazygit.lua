local open_lazygit = function()
  vim.cmd('tabedit')
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = 'no'

  vim.fn.termopen('env VIMRUNTIME= VIM= lazygit', {
    on_exit = function()
      vim.cmd('silent! checktime')
      vim.cmd('silent! bwipeout!')
    end,
  })

  vim.cmd('startinsert')
  vim.b.minipairs_disable = true
end

vim.keymap.set('n', '<leader>gg', open_lazygit, { desc = 'Git tab', silent = true })
