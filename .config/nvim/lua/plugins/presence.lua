return {
  "andweeb/presence.nvim",
  event = "VeryLazy",
  config = function()
    require("presence").setup{
      auto_update = true,
      neovim_image_text = "The Superior Text Editor",
      main_image = "file",
      client_id = "793271441293967371",
      log_level = nil,
      debounce_timeout = 10,
      blacklist = {},
      file_assest = {},
      enable_line_number = false,
      show_time = true,

      editing_text = "Editing %s",
      file_explorer_text = "Browsing %s",
      git_commit_text = "Commiting Changes",
      workspace_text      = "Working on %s",
      plugin_manager_text = "Managing Plugins",
    }
  end,
}
