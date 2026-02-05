return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      sync_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      textobjects = { enable = false },
      indent = { enable = true },
      ensure_installed = {
        "bash",
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
        "markdown_inline",
        "c",
      },
    })
  end
}
