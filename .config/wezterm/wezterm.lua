local wezterm = require("wezterm")
local mux = wezterm.mux

local config = wezterm.config_builder()

config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.color_scheme = "tokyonight_night"
config.colors = {
  indexed = { [241] = "#65bcff" },
  background = "#080A18",
}

config.initial_rows = 30
config.initial_cols = 120

config.underline_thickness = 3
config.cursor_thickness = 4
config.underline_position = -6

config.font_size = 15
config.font = wezterm.font({ family = "CaskaydiaCove Nerd Font Mono" })
config.font_rules = {
  {
    italic = true,
    intensity = "Normal",
    font = wezterm.font({ family = "Fira Code", style = "Italic" })
  }
}
config.bold_brightens_ansi_colors = true

config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
config.scrollback_lines = 10000

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 10

config.window_close_confirmation = "NeverPrompt"

return config
