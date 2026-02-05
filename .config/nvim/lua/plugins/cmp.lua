return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = {
    keymap = {
      preset = "super-tab",
    },
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
      },
      menu = {
        min_width = 15,
        max_height = 10,
        border = "rounded",
        scrollbar = false,
        draw = {
          padding = 1,
          columns = { { "kind_icon", gap = 1}, { "label", "label_description", "kind", gap = 2 } },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        treesitter_highlighting = true,
        window = {
          border = "rounded",
          scrollbar = false,
        }
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    cmdline = {
      enabled = false,
    },
  }
}
