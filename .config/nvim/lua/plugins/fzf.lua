return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      "telescope",
      fzf_colors = {
        ["gutter"] = "-1",
      }
    })
    local keymap = vim.keymap
    keymap.set("n", "<leader>f", require('fzf-lua').files, { desc = "FZF Files" })
    keymap.set("n", "<leader>g", require('fzf-lua').live_grep, { desc = "FZF Grep" })
  end
}
