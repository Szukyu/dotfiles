return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec " },
  opts = {
    preset = "modern",
    defaults = {},
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>g", group = "git"},
        { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
      }
    }
  }
}
