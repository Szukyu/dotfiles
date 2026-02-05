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
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
      },
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function (name, _)
          return name == ".git" or name == ".DS_Store" or name == ".localized" or name == ".gitignore"
        end
      }
    }
  end
}
