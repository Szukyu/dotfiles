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
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function (name, _)
          return name == ".git" or name == ".DS_Store"
        end
      }
    }

    local keymap = vim.keymap
    keymap.set("n", "<leader>e", require("oil").toggle_float)
  end
}
