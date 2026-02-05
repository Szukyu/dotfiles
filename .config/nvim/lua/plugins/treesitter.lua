return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufWritePost", "BufNewFile"},
  lazy = vim.fn.argc(-1) == 0,
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>", desc = "Decrement Selection", mode = "x" },
  },
  opts_extend = { "ensure_installed" },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "diff",
      "html",
      "javascript",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
