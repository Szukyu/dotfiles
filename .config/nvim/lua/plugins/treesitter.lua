return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "html",
        "css",
        "lua",
        "vim",
        "gitcommit",
        "gitignore",
        "cpp",
      },
    })
  end
}
