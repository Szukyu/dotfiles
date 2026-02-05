return {
  "saghen/blink.cmp",
  lazy = false,
  version = "v0.*",
  dependencies = {
    'rafamadriz/friendly-snippets',
  },

  opts = {
    keymap = {
      preset = 'super-tab',
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      kind_icons = {
        Text = "",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰇽",
        Variable = "󰂡",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰅲",
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', }
    },
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
      },
      menu = {
        enabled = true,
        min_width = 15,
        max_height = 10,
        border = "rounded",
        winhighlight = "Normal:BlinkCmpMenu",
        scrollbar = false,
        draw = {
          padding = 1,
          columns = { { "kind_icon", gap = 1}, { "label", "label_description", "kind", gap = 2 } },
        }
      },
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
          winhightlight = "Normal:BlinkCmpMenu",
          scrollbar = true,
        }
      },
    }
  }
}


