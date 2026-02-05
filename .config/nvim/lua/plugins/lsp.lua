vim.g.lsp_servers = {
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

vim.g.other_mason_servers = {
  "stylua",
  "prettier",
  "isort",
  "black",
  "ruff",
  "eslint_d"
}

return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
    event = { "VeryLazy", "BufReadPre", "BufNewFile" },
    config = function(_)
      local mr = require("mason-registry")
      mr.refresh(function()
        for _, tool in ipairs(vim.g.other_mason_servers) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)

      -- Configure and get names of lsp servers
      local lsp_server_names = {}
      for lsp_server_name, _ in pairs(vim.g.lsp_servers) do
        -- Add custom config settings
        local lsp_server_settings = vim.g.lsp_servers[lsp_server_name] or {}
        vim.lsp.config(lsp_server_name, lsp_server_settings)

        table.insert(lsp_server_names, lsp_server_name)
      end

      local capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)
      vim.lsp.config("*", { capabilities = capabilities })

      require("mason-lspconfig").setup({
        ensure_installed = lsp_server_names,
        automatic_enable = true,
      })

      vim.lsp.set_log_level("off")

      -- local hover = vim.lsp.buf.hover
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- vim.lsp.buf.hover = function()
        --   return hover({
          --     border = "rounded",
          --     max_height = math.floor(vim.o.lines * 0.5),
          --     max_width = math.floor(vim.o.columns * 0.4),
          --   })
          -- end

          -- local signature_help = vim.lsp.buf.signature_help
          -- ---@diagnostic disable-next-line: duplicate-set-field
          -- vim.lsp.buf.signature_help = function()
            --   return signature_help({
              --     border = "rounded",
              --     max_height = math.floor(vim.o.lines * 0.5),
              --     max_width = math.floor(vim.o.columns * 0.4),
              --   })
              -- end

              -- wrappers to allow for toggling
              local def_virtual_text = {
                isTrue = {
                  severity = { max = "WARN" },
                  source = "if_many",
                  spacing = 4,
                  prefix = "● ",
                },
                isFalse = false,
              }

              local function truncate_message(message, max_length)
                if #message > max_length then
                  return message:sub(1, max_length) .. "..."
                end
                return message
              end

              local def_virtual_lines = {
                isTrue = {
                  current_line = true,
                  severity = { min = "ERROR" },
                  format = function(diagnostic)
                    local max_length = 100 -- Set your preferred max length
                    return "● " .. truncate_message(diagnostic.message, max_length)
                  end,
                },
                isFalse = false,
              }

              local default_diagnostic_config = {
                update_in_insert = false,
                virtual_lines = def_virtual_lines.isTrue,
                virtual_text = def_virtual_text.isTrue,
                underline = true,
                severity_sort = true,
                float = {
                  focusable = false,
                  style = "minimal",
                  border = "rounded",
                  source = "always",
                  header = "",
                  prefix = "",
                },
                signs = {
                  text = {
                    -- [vim.diagnostic.severity.ERROR] = " ",
                    -- [vim.diagnostic.severity.WARN] = " ",
                    -- [vim.diagnostic.severity.INFO] = " ",
                    -- [vim.diagnostic.severity.HINT] = " ",
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                    [vim.diagnostic.severity.INFO] = "",
                    [vim.diagnostic.severity.HINT] = "",
                  },
                  numhl = {
                    [vim.diagnostic.severity.ERROR] = "ErrorMsg", -- Just cause its also bold
                    [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
                    [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
                    [vim.diagnostic.severity.HINT] = "DiagnosticHint",
                  },
                },
              }

              vim.diagnostic.config(default_diagnostic_config)

              -- Set Toggles
              Snacks.toggle
              .new({
                id = "Virtual diagnostics (Lines)",
                name = "Virtual diagnostics (Lines)",
                get = function()
                  if vim.diagnostic.config().virtual_lines then
                    return true
                  else
                    return false
                  end
                end,
                set = function(state)
                  if state == true then
                    vim.diagnostic.config({ virtual_lines = def_virtual_lines.isTrue })
                  else
                    vim.diagnostic.config({ virtual_lines = def_virtual_lines.isFalse })
                  end
                end,
              })
              :map("<leader>uvl")
            end,
          },
        }
