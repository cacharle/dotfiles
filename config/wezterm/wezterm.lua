local wezterm = require "wezterm"
local config = wezterm.config_builder()
local act = wezterm.action

config.font_size = 11
config.font = wezterm.font "Fira Code"
config.color_scheme = "GruvboxDark"
config.enable_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_close_confirmation = "NeverPrompt"
config.warn_about_missing_glyphs = false
config.adjust_window_size_when_changing_font_size = false

config.keys = {
    { key = "K", mods = "ALT", action = act.ScrollByLine(-10) },
    { key = "J", mods = "ALT", action = act.ScrollByLine(10) },
    { key = "k", mods = "ALT", action = act.SendString("\x1B[A") },
    { key = "j", mods = "ALT", action = act.SendString("\x1B[B") },
    -- Some bindings that get triggered when I forgot about capslock in vim
    { key = "u", mods = "CTRL|SHIFT", action = "DisableDefaultAssignment" },
    { key = "n", mods = "CTRL|SHIFT", action = "DisableDefaultAssignment" },
}

return config
