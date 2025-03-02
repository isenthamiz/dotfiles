local wezterm = require "wezterm"
local config = wezterm.config_builder()
local action = wezterm.action

-- Variables
-- hsb values for the background dimmer
local dimmer = {
  brightness = 0.10,
  hue = 1.0,
  saturation = 0.6,
}

-- Helper Functions

-- Get the list of wallpapers from the directory
local wallpaper_dir = '/Users/senthamiz/.config/wezterm/backgrounds/'

local function get_wallpaper_list()
  local wallpapers = {}
  local pfile = io.popen('ls "' .. wallpaper_dir .. '"')
  if pfile then
    for filename in pfile:lines() do
      table.insert(wallpapers, wallpaper_dir .. filename)
    end
    pfile:close()
  end
  return wallpapers
end

local wallpapers = get_wallpaper_list()

-- Get the next wallpaper from the list
local function get_next_wallpaper()
  if #wallpapers > 0 then
    return wallpapers[math.random(1, #wallpapers)]
  end
  return nil
end

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
config.color_scheme = 'nightfox'

-- Background Configurations
config.background = {
  {
    source = {
      File = '/Users/senthamiz/.config/wezterm/backgrounds/HERO202411144-3840x2160.jpg',
    },
    hsb = dimmer,
  },
}
-- Background Configuration with Random Wallpaper
-- config.background = {
--   {
--     source = {
--       File = get_next_wallpaper(),
--     },
--     hsb = dimmer,
--   },
-- }

-- Window Style
config.window_padding = {
  left = '1cell',
  right = '1cell',
  top = '1cell',
  bottom = '0cell'
}
config.window_decorations = 'RESIZE'
config.enable_tab_bar = false
-- config.window_background_opacity = 0.70
-- config.macos_window_background_blur = 80
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
