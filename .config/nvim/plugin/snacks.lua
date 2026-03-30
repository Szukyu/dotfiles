vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

require('snacks').setup({
  bigfile = {
    enabled = true
  },
  picker = {
    sources = {
      explorer = {
        auto_close = true,
        hidden = true,
      },
      files = {
        hidden = true,
      },
      grep = {
        hidden = true,
      },
    },
    layouts = {
      default = {
        layout = {
          width = 0.9,
          height = 0.9,
        }
      }
    }
  },
  quickfile = { enabled = true },
  words = { enabled = true },
  input = { enabled = true },
  indent = { enabled = true },
})
