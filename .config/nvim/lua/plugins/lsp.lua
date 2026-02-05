return {
  {
    "neovim/nvim-lspconfig",
  },

  {
    "mason-org/mason.nvim",
    opts = {
      max_concurrent_installers = 20,
      ui = {
        height = 0.8,
        icons = {
          package_installed = tools.ui.icons.bullet,
          package_pending = tools.ui.icons.ellipses,
          package_uninstalled = tools.ui.icons.open_bullet,
        },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "neovim/nvim-lspconfig",
    opts = {
      handlers = {
        function(name) vim.lsp.enable(name) end,
      },
    },
  },
}
