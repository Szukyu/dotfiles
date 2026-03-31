local S = vim.diagnostic.severity

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim.git',
  'https://github.com/mason-org/mason-lspconfig.nvim.git'
})

require('mason').setup({
  ensure_installed = {
    'black',
    'eslint_d',
    'isort',
    'prettier',
    'stylua'
  }
})

require('mason-lspconfig').setup({
  ensure_installed = {
    'basedpyright',
    'clangd',
    'cssls',
    'html',
    'lua_ls',
    'ruff',
    'tailwindcss',
    'ts_ls',
  }
})

vim.diagnostic.config({
  underline = true,
  severity_sort = true,
  virtual_text = {
    prefix = "",
    format = function(diag)
      local clean_src_names = {
        ["Lua Diagnostics."] = "lua",
        ["Lua Syntax Check."] = "lua",
      }

      local msg
      if not diag.code then return diag end

      msg = diag.message

      if diag.source then
        msg = string.format(
          "%s [%s]",
          msg,
          clean_src_names[diag.source] or diag.source
        )
      end

      return msg
    end,
  },
  signs = {
    text = {
      [S.ERROR] = "",
      [S.HINT] = "",
      [S.INFO] = "",
      [S.WARN] = "",
    },
  },
})

vim.lsp.document_color.enable(true, nil, { style = 'virtual' })
vim.lsp.enable({ 'lua_ls', 'clangd' })
