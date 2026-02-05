return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
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
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf }, { silent = true })
      end
    })

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end
}
