return {
  "saghen/blink.cmp",
  lazy = false,
  version = "v0.*",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
    }
  },

  opts = {
    keymap = {
      preset = 'super-tab',
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
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
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
      },
      menu = {
        min_width = 15,
        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            local pos = vim.g.ui_cmdline_pos
            return { pos[1] - 1, pos[2] }
          end
          local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          return { vim.o.lines - height, 0 }
        end,
        max_height = 10,
        border = "rounded",
        scrollbar = false,
        draw = {
          padding = 1,
          columns = { { "kind_icon", gap = 1}, { "label", "label_description", "kind", gap = 2 } },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
              highlight = function(ctx)
                return require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx) or ('BlinkCmpKind' .. ctx.kind)
              end,
            },

            kind = {
              ellipsis = false,
              width = { fill = true },
              text = function(ctx) return ctx.kind end,
              highlight = function(ctx)
                return require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx) or ('BlinkCmpKind' .. ctx.kind)
              end,
            },

            label = {
              width = { fill = true, max = 60 },
              text = function(ctx) return ctx.label .. ctx.label_detail end,
              highlight = function(ctx)
                local highlights = {
                  { 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
                }
                if ctx.label_detail then
                  table.insert(highlights, { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' })
                end

                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                end

                return highlights
              end,
            },

            label_description = {
              width = { max = 30 },
              text = function(ctx) return ctx.label_description end,
              highlight = 'BlinkCmpLabelDescription',
            }
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        treesitter_highlighting = false,
        window = {
          border = "rounded",
          scrollbar = false,
        }
      },
    },
  },
}
