return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    "mason.nvim",
    { "williamboman/mason-lspconfig.nvim", config = function() end },
  },

  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "Snacks" },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        }
      },
      clangd = {},
      tailwindcss = {
        settings = {
          includeLanguages = {
            templ = "html",
          },
        },
      },
      ts_ls = {},
      html = {},
      cssls = {},
      basedpyright = {
        settings = {
          basedpyright = {
            typeCheckingMode = "off",
          }
        }
      },
    }
  },

  config = function (_, opts)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local buf = { buffer = ev.buf, desc = "Rename Variable" }
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, buf)
      end
    })

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.INFO] = "󰋼 ",
          [vim.diagnostic.severity.HINT] = "󰌵 ",
        },
      },
    })

    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end
}
