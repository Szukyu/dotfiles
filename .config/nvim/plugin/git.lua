local open_lazygit = function()
  vim.cmd('tabedit') 
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = 'no'

  -- Get git paths safely
  local git_dir = vim.fn.system('git rev-parse --git-dir'):gsub('\n', '')
  local work_tree = vim.fn.getcwd()

  -- Run lazygit
  vim.fn.termopen(string.format('env VIMRUNTIME= VIM= lazygit --git-dir=%s --work-tree=%s', git_dir, work_tree), {
    on_exit = function()
      -- Close the tab/buffer when lazygit exits
      vim.cmd('silent! checktime')
      vim.cmd('silent! bwipeout!')
    end,
  })

  vim.cmd('startinsert')
end

vim.keymap.set('n', '<leader>gg', open_lazygit, { desc = 'Git tab', silent = true })
