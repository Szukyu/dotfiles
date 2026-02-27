_G.tools = {
  ui = {
    icons = {
      branch = "",
      bullet = "•",
      open_bullet = "○",
      ok = "✔",
      d_chev = "∨",
      ellipses = "…",
      document = "≡",
      lock = "",
      r_chev = ">",
      diag = "▫",
      info = "󰌶 ",
    },
    kind_icons = {
      Array = " 󰅪 ",
      BlockMappingPair = " 󰅩 ",
      Boolean = "  ",
      BreakStatement = " 󰙧 ",
      Call = " 󰃷 ",
      CaseStatement = " 󰨚 ",
      Class = "  ",
      Color = "  ",
      Constant = "  ",
      Constructor = " 󰆧 ",
      ContinueStatement = "  ",
      Copilot = "  ",
      Declaration = " 󰙠 ",
      Delete = " 󰩺 ",
      DoStatement = " 󰑖 ",
      Element = " 󰅩 ",
      Enum = "  ",
      EnumMember = "  ",
      Event = "  ",
      Field = "  ",
      File = "  ",
      Folder = "  ",
      ForStatement = "󰑖 ",
      Function = " 󰆧 ",
      GotoStatement = " 󰁔 ",
      Identifier = " 󰀫 ",
      IfStatement = " 󰇉 ",
      Interface = "  ",
      Keyword = "  ",
      List = " 󰅪 ",
      Log = " 󰦪 ",
      Lsp = "  ",
      Macro = " 󰁌 ",
      MarkdownH1 = " 󰉫 ",
      MarkdownH2 = " 󰉬 ",
      MarkdownH3 = " 󰉭 ",
      MarkdownH4 = " 󰉮 ",
      MarkdownH5 = " 󰉯 ",
      MarkdownH6 = " 󰉰 ",
      Method = " 󰆧 ",
      Module = " 󰅩 ",
      Namespace = " 󰅩 ",
      Null = " 󰢤 ",
      Number = " 󰎠 ",
      Object = " 󰅩 ",
      Operator = "  ",
      Package = " 󰆧 ",
      Pair = " 󰅪 ",
      Property = "  ",
      Reference = "  ",
      Regex = "  ",
      Repeat = " 󰑖 ",
      Return = " 󰌑 ",
      RuleSet = " 󰅩 ",
      Scope = " 󰅩 ",
      Section = " 󰅩 ",
      Snippet = " 󱄽 ",
      Specifier = " 󰦪 ",
      Statement = " 󰅩 ",
      String = "  ",
      Struct = "  ",
      SwitchStatement = " 󰨙 ",
      Table = " 󰅩 ",
      Terminal = "  ",
      Text = " 󰀬 ",
      Type = "  ",
      TypeParameter = "  ",
      Unit = "  ",
      Value = "  ",
      Variable = "  ",
      WhileStatement = " 󰑖 ",
    },
  },
  nonprog_modes = {
    ["markdown"] = true,
    ["org"] = true,
    ["orgagenda"] = true,
    ["text"] = true,
  },
}

-- files and directories -----------------------------
local branch_cache = setmetatable({}, { __mode = "k" })
local remote_cache = setmetatable({}, { __mode = "k" })

--- get the path to the root of the current file. The
-- root can be anything we define, such as ".git",
-- "Makefile", etc.
-- see https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/
-- @tparam  path: file to get root of
-- @treturn path to the root of the filepath parameter
tools.get_path_root = function(path)
  if path == "" then return end

  local root = vim.b.path_root
  if root then return root end

  local root_items = {
    ".git",
  }

  root = vim.fs.root(path, root_items)
  if root == nil then return nil end
  if root then vim.b.path_root = root end
  return root
end

local function git_cmd(root, ...)
  local job = vim.system({ "git", "-C", root, ... }, { text = true }):wait()

  if job.code ~= 0 then return nil, job.stderr end
  return vim.trim(job.stdout)
end

-- get the name of the remote repository
tools.get_git_remote_name = function(root)
  if not root then return nil end
  if remote_cache[root] then return remote_cache[root] end

  local out = git_cmd(root, "config", "--get", "remote.origin.url")
  if not out then return nil end

  -- normalise to short repo name
  out = out:gsub(":", "/"):gsub("%.git$", ""):match("([^/]+/[^/]+)$")

  remote_cache[root] = out
  return out
end

function tools.get_git_branch(root)
  if not root then return nil end
  if branch_cache[root] then return branch_cache[root] end

  local out = git_cmd(root, "rev-parse", "--abbrev-ref", "HEAD")
  if out == "HEAD" then
    local commit = git_cmd(root, "rev-parse", "--short", "HEAD")
    commit = tools.hl_str("Comment", "(" .. commit .. ")")
    out = string.format("%s %s", out, commit)
  end

  branch_cache[root] = out

  return out
end

-- LSP -----------------------------
tools.diagnostics_available = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local diagnostics = vim.lsp.protocol.Methods.textDocument_publishDiagnostics

  for _, cfg in pairs(clients) do
    if cfg:supports_method(diagnostics) then return true end
  end

  return false
end

-- highlighting -----------------------------
tools.hl_str = function(hl, str) return "%#" .. hl .. "#" .. str .. "%*" end

tools.get_hl_hex = function(hl_group)
  assert(hl_group, "Error: Must have hl group name")

  local hl = vim.api.nvim_get_hl(0, { name = hl_group })

  return {
    fg = hl.fg and ("#%06x"):format(hl.fg) or nil,
    bg = hl.bg and ("#%06x"):format(hl.bg) or nil,
  }
end

local statusline_hls = {}

function tools.get_or_create_hl(hl_fg, hl_bg)
  hl_bg = hl_bg or "Normal"
  local sanitized_hl_fg = hl_fg:gsub("#", "")
  local sanitized_hl_bg = hl_bg:gsub("#", "")
  local hl_name = "SL" .. sanitized_hl_fg .. sanitized_hl_bg

  if not statusline_hls[hl_name] then
    -- If not in the cache, create the highlight group
    local bg_hl
    if hl_bg:match("^#") then
      -- If hl_bg starts with #, it's a hex color
      bg_hl = { bg = hl_bg }
    else
      -- Otherwise treat it as highlight group name
      bg_hl = vim.api.nvim_get_hl(0, { name = hl_bg })
    end

    local fg_hl
    if hl_fg:match("^#") then
      -- If hl_fg starts with #, it's a hex color
      fg_hl = { fg = hl_fg }
    else
      -- Otherwise treat it as highlight group name
      fg_hl = vim.api.nvim_get_hl(0, { name = hl_fg })
    end

    if not bg_hl.bg then
      bg_hl = vim.api.nvim_get_hl(0, { name = "Statusline" })
    end
    if not fg_hl.fg then
      fg_hl = vim.api.nvim_get_hl(0, { name = "Statusline" })
    end

    vim.api.nvim_set_hl(0, hl_name, {
      bg = bg_hl.bg and (type(bg_hl.bg) == "string" and bg_hl.bg or ("#%06x"):format(bg_hl.bg)) or "none",
      fg = fg_hl.fg and (type(fg_hl.fg) == "string" and fg_hl.fg or ("#%06x"):format(fg_hl.fg)) or "none",
    })
    statusline_hls[hl_name] = true
  end

  return "%#" .. hl_name .. "#"
end

-- insert grouping separators in numbers
tools.group_number = function(num, sep)
  if num < 999 then return tostring(num) end

  num = tostring(num)
  return num:reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
end
