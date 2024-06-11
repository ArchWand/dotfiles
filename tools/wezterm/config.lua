local M = {}

function M.apply_to_config(config)
  config.audible_bell = "Disabled"
  config.automatically_reload_config = false
  -- config.clean_exit_codes = { 130 }
  config.enable_kitty_keyboard = false
  config.enable_scroll_bar = false
  config.enable_wayland = false
  config.exit_behavior = "Close"
  config.exit_behavior_messaging = "Terse"
  config.swallow_mouse_click_on_window_focus = false -- even on MacOS
  config.use_resize_increments = true
  config.window_decorations = "RESIZE"
end

return M
