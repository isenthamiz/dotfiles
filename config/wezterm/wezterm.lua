local wezterm = require "wezterm"
local config = wezterm.config_builder()
local action = wezterm.action

-- Text and Font Configuration
config.font = wezterm.font('MesloLGS Nerd Font Mono')
config.font_size = 19.0
config.line_height = 1.2

-- Cursor
config.colors = {
  cursor_bg = 'white',
  cursor_border = 'white'
}
config.default_cursor_style = 'BlinkingUnderline'

-- ColorScheme Configurations
config.color_scheme_dirs = { wezterm.home_dir .. '/.config/wezterm/color-schemes' }
--config.color_scheme = 'Monokai Pro Light'
--config.color_scheme = 'nightfox'
--config.color_scheme = 'Obsidian'
--config.color_scheme = 'Dark Modern'
config.color_scheme = 'Tokyonight'

config.window_padding = {
  left = '0.5cell',
  right = '0.5cell',
  top = '0.5cell',
  bottom = '0cell'
}

-- Window Style
config.window_decorations = 'RESIZE'
config.enable_tab_bar = false
config.window_background_opacity = 0.70
config.macos_window_background_blur = 80
config.initial_cols = 120
config.initial_rows = 50

-- By default, Wezterm interprets the Option key as Meta key, which might prevent Option + 1, 2, 3.
-- Below configuraiton will ensure to enable Option key.
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

-- Key Mappings

config.leader = {
  key = 'a',
  mods = 'OPT',
  timeout_milliseconds = 2000
}

config.keys = {
  {
    key = '|',
    mods = 'LEADER',
    action = action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'z',
    mods = 'LEADER',
    action = action.ToggleFullScreen,
  }

}

return config
