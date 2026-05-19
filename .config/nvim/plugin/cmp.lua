vim.pack.add({ 'https://github.com/saghen/blink.lib' })
vim.pack.add({ 'https://github.com/saghen/blink.cmp' })

require("blink.cmp").setup({
  completion = {
    list = {
      selection = {
        preselect = true,
        auto_insert = true,
      }
    },
    menu = {
      scrollbar = false,
      draw = {
        gap = 2,
        columns = {
          { 'kind_icon', 'kind', gap = 1 },
          { 'label', 'label_description', gap = 1 },
        },
      },
    },
    documentation = {
      auto_show = true,
    },
  },

  keymap = {
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<Tab>"] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      "snippet_forward",
      "fallback",
    },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<Up>"] = { "fallback" },
    ["<Down>"] = { "fallback" },
  },

  fuzzy = {
    implementation = "lua",
  },
})
