return {
  "akinsho/bufferline.nvim",
  config = function()
    local bufferline = require('bufferline')

    bufferline.setup({
      options = {
        separator_style = "slope",
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold,
        },
      },
    })
  end,
}
