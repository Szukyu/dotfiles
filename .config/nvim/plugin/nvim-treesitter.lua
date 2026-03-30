vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

require("nvim-treesitter.install").update("all")
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "c",
    "css",
    "cpp",
    "diff",
    "html",
    "json",
    "javascript",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "toml",
    "tsx",
    "typescript",
    "vim"
  },
  indent = { enable = true },
  highlight = { enable = true },
})

vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and kind == 'update' then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })
