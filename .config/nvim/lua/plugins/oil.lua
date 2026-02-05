return {
  "stevearc/oil.nvim",
  dependencies = {
    {
      "echasnovski/mini.icons", opts = {}
    },
  },
  opts = {},
  config = function ()
    require("oil").setup {
    }

    local keymap = vim.keymap
    keymap.set("n", "<leader>e", require("oil").toggle_float)
  end
}
