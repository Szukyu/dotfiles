return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "echasnovski/mini.icons"
  },
  config = function()
    require("fzf-lua").setup({
      winopts = {
        height = 0.85,
        width = 0.95,
        preview = {
          horizontal = "right:45%",
          scrollbar = false,
        },
      },
      defaults = {
        no_header = true,
      },
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      fzf_colors = {
        ["gutter"] = "-1",
        ["bg+"] = "#170B3B"
      }
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>f", require('fzf-lua').files, { desc = "Find Files" })
    keymap.set("n", "<leader>/", require('fzf-lua').live_grep, { desc = "Grep" })
  end
}
