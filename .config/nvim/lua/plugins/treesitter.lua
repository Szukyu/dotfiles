return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    indent = { enable = true },
    highlight = { enable = true },
    folds = { enable = true },
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
      "vim",

    }
  },
  config = function()
    local TS= require("nvim-treesitter")
    TS.setup(opts)
  end,
}
