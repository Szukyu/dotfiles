return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "moon",
    lualine_bold = true,
    on_colors = function(colors)
      colors.bg = "#080A18"
      colors.bg_float = "#04050B"
      colors.bg_sidebar = "#03040A"
      colors.bg_statusline = "NONE" --"#06080E"
      colors.bg_popup = "#04050B"
    end,
    on_highlights = function(highlights, _)
      highlights.BlinkCmpMenuBorder = {
        bg = "#080A18",
        fg = "#27A1b9",
      }
      highlights.BlinkCmpDoc = {
        bg = "#04050B",
        fg = "#c0caf5",
      }
      highlights.BlinkCmpDocBorder = {
        bg = "#080A18",
        fg = "#27A1b9",
      }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
