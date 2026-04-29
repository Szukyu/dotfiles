vim.pack.add({ 'https://github.com/folke/tokyonight.nvim' })

require("tokyonight").setup({
  style = "moon",
  lualine_bold = true,
  transparent = false,
  on_colors = function(colors)
    colors.bg = "#000000"
    colors.bg_float = "#04050B"
    colors.bg_sidebar = "#03040A"
    colors.bg_statusline = "NONE"
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
    highlights.SnippetTabstop = { link = "NONE" }
  end,
})

vim.cmd.colorscheme("tokyonight")
