local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  print("New Setup! Initializing …")

  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazy_path,
  })
end

vim.opt.runtimepath:prepend(lazy_path)

require("globals")
require("options")
require("maps")
-- require("aucmd")

require("lazy").setup("plugins", {
  change_detection = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  defaults = { lazy = false },
  ui = {
    backdrop = 100,
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    pills = true,
    icons = {
      cmd = tools.ui.kind_icons.Terminal,
      config = "󰒓 ",
      debug = "● ",
      event = " ",
      favorite = "  ",
      ft = tools.ui.kind_icons.File,
      init = "󰒓 ",
      import = " 󰋺  ",
      keys = " 󰥻  ",
      lazy = "󰒲  ",
      loaded = tools.ui.icons.bullet,
      not_loaded = tools.ui.icons.open_bullet,
      plugin = tools.ui.kind_icons.Module,
      runtime = "  ",
      require = "󰢱  ",
      source = " ",
      start = " ",
      task = tools.ui.icons.ok,
      list = { "■", "□", "●", "○", "◆", "◊" },
    },
  },
})

require("ui")
