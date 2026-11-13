local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
-- Fira Code is installed locally; WezTerm supplies symbol and emoji fallbacks.
config.font = wezterm.font_with_fallback({ 'Fira Code', 'Symbols Nerd Font Mono', 'Noto Color Emoji' })
config.font_size = 12.0
config.window_background_opacity = 1.0
config.background = {
  {
    source = { File = wezterm.config_dir .. '/wallpaper.png' },
    hsb = { brightness = 0.12, saturation = 0.8, hue = 1.0 },
    opacity = 1.0,
  },
}
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = 'NeverPrompt'
config.scrollback_lines = 10000
config.adjust_window_size_when_changing_font_size = false

config.keys = {
  { key = 'Enter', mods = 'SHIFT', action = wezterm.action.SendString '\x0a' },
  { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CTRL|ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
}

return config
