vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim.git',
  'https://github.com/mason-org/mason-lspconfig.nvim.git'
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensured_installed = {
    'basedpyright',
    'black',
    'clangd',
    'css-lsp',
    'eslint_d',
    'html-lsp',
    'isort',
    'lua_ls',
    'prettier',
    'ruff',
    'stylua',
    'tailwindcss',
    'ts_ls',
  }
})

vim.lsp.enable({ 'lua_ls', 'clangd' })
