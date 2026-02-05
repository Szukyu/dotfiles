return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  dependencies = {
    "mason.nvim",
    "saghen/blink.cmp",
    {
      "linrongbin16/lsp-progress.nvim",
      opts = {
        max_size = 50,
        spinner = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" },
        client_format = function(_, spinner, series_messages)
          return #series_messages > 0
          and (spinner .. " LSP")
          or nil
        end,
        format = function(client_messages)
          if #client_messages > 0 then
            return table.concat(client_messages, " ")
          end
          return ""
        end,
      },
    },
  },
  config = function()
    local x = vim.diagnostic.severity

    local opts = {
      diagnostics = {
        virtual_text = { prefix = "" },
        virtual_lines = false,
        signs = {
          text = { [x.ERROR] = "", [x.WARN] = "", [x.INFO] = "", [x.HINT] = ""},
          numhl = {
            [x.WARN] = "WarningMsg",
            [x.ERROR] = "ErrorMsg",
            [x.INFO] = "DiagnosticInfo",
            [x.HINT] = "DiagnosticHint",
          },
        },
        underline = true,
        float = { border = "rounded" },
      },
      settings = {
        lua_ls = require("config.lsp.settings.lua_ls"),
        basedpyright = require("config.lsp.settings.basedpyright"),
        tailwindcss = require("config.lsp.settings.tailwindcss"),
      }
    }

    vim.diagnostic.config(opts.diagnostics)

    -- UI border
    require("lspconfig.ui.windows").default_options.border = "rounded"

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    capabilities.workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    }

    local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, opts.settings[server] or {})

      require("lspconfig")[server].setup(server_opts)
    end

    local servers_lists = require("config.lsp.server")
    local installed_servers = require("mason-registry").get_installed_package_names()
    local servers_mapping = servers_lists.names_mapping

    for _, server in ipairs(servers_lists.ensure_installed) do
      if vim.tbl_contains(installed_servers, server) and servers_mapping[server] then
        setup(servers_mapping[server])
      end
    end
  end
}
