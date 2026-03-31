function Get_lsp_diagnostics()
  local diagnostics = {
    { severity = vim.diagnostic.severity.ERROR, icon = "󰅚 ", hl = "%#DiagnosticError#" },
    { severity = vim.diagnostic.severity.WARN,  icon = "󰀪 ", hl = "%#DiagnosticWarn#"  },
    { severity = vim.diagnostic.severity.INFO,  icon = "󰋽 ", hl = "%#DiagnosticInfo#"  },
    { severity = vim.diagnostic.severity.HINT,  icon = "󰌶 ", hl = "%#DiagnosticHint#"  },
  }

  local parts = {}
  for _, item in ipairs(diagnostics) do
    local count = #vim.diagnostic.get(0, { severity = item.severity })
    if count > 0 then
      table.insert(parts, item.hl .. item.icon .. count .. "%*")
    end
  end

  return table.concat(parts, " ")
end

local stl = {
  "%f",
  " %m",
  "%r",
  "%=",
  "%{%v:lua.Get_lsp_diagnostics()%}",
  " %y ",
  " %l:%c ",
  "%P "
}

vim.opt.statusline = table.concat(stl, "")
