return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec" },
  opts = {
    preset = "modern",
    defaults = {},
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>e", icon = { icon = "󰙅 ", color = "orange" } },
        { "<leader>/", icon = { icon = "󱡠 " } },
        { "<leader>:", icon = { icon = "󱡠 " } },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>q", group = "quit/session" },
        { "<leader>s", group = "search" },
        { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },
      },
    },
  },
}
