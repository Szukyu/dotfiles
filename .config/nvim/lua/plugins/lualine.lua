return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  config = function()
    local lualine = require("lualine")
    lualine.setup({
      options = {
        icons_enabled = true,
        globalstatus = 3,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "diagnostics", icons_enabled = true, colored = true },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0} },
          { "filename", path = 1, padding = { left = 0, right = 0} }
        },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return { fg = Snacks.util.color("Special") } end,
          },
          {
            "diff",
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
      },
      extensions = { 'oil', 'lazy', 'fzf' },
    })
  end,
}
