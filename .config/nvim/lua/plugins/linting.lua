return {
  'mfussenegger/nvim-lint',
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      python = { 'ruff' },
    }
  },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft
  end,
}

