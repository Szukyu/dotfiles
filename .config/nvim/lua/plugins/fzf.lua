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
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      fzf_colors = {
        ["bg+"] = "#04050B",
        ["gutter"] = "-1",
      }
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>f", require('fzf-lua').files, { desc = "FZF Files" })
    keymap.set("n", "<leader>g", require('fzf-lua').live_grep, { desc = "FZF Grep" })
  end
}
