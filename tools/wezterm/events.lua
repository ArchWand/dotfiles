local M = {}

function M.apply_to_config(config)
  -- Keep centered
  wezterm.on("window-resized", function(window, pane)
    util.minimize_padding(window, pane, config.font_size, config.window_padding)
  end);

end

return M
