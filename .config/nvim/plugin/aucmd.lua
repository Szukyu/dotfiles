local augrp = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd
local get_opt = vim.api.nvim_get_option_value
local grp

---- Upon entering
grp = augrp("Entering", { clear = true })

aucmd("BufNewFile", {
  group = grp,
  command = "silent! 0r "
  .. vim.fn.stdpath("config")
  .. "/templates/skeleton.%:e",
  desc = "If one exists, use a template when opening a new file",
})

aucmd("BufWinEnter", {
  group = grp,
  command = "silent! loadview",
  desc = "Restore view settings",
})

-- See https://vi.stackexchange.com/a/12710
aucmd("BufWinEnter", {
  group = grp,
  command = [[call matchadd("String", '\v[a-zA-Z0-9._%+-]+\@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}')]],
  desc = "Highlight email addresses",
})

---- During editing
grp = augrp("Editing", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved", "CursorHoldI" }, {
  group = grp,
  callback = function()
    local win_h = vim.api.nvim_win_get_height(0)
    local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
    local dist = vim.fn.line("$") - vim.fn.line(".")
    local rem = vim.fn.line("w$") - vim.fn.line("w0") + 1

    if dist < off and win_h - rem + dist < off then
      local view = vim.fn.winsaveview()
      view.topline = view.topline + off - (win_h - rem + dist)
      vim.fn.winrestview(view)
    end
  end,
  desc = "When at eob, bring the current line towards center screen",
})

vim.api.nvim_create_autocmd("VimResized", {
  group = grp,
  command = [[tabdo wincmd =]],
})

---- Upon leaving a buffer
grp = augrp("Leaving", { clear = true })

aucmd("BufWinLeave", {
  group = grp,
  command = "silent! mkview",
  desc = "Create view settings",
})
