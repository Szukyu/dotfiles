vim.pack.add({ 'https://github.com/saghen/blink.cmp' })

require("blink.cmp").setup({
  completion = {
    menu = {
      scrollbar = false
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
  }
})
