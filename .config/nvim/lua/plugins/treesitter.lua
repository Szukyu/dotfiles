return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      sync_install = true,
      highlight = {
        enable = true,
      },
      textobjects = { enable = false },
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
        "markdown",
      },
    })
  end
}
