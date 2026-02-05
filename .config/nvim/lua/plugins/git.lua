return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  config = function()
    require("gitsigns").setup()
  end,
}
