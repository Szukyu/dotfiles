return {
  "folke/which-key.nvim",
  enabled = true,
  opts = {
    preset = "modern",
    debug = vim.uv.cwd():find("which%-key"),
    win = {},
    spec = {}
  }
}
