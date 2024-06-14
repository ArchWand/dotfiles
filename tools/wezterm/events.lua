local M = {}

function M.apply_to_config(config)
  local cfg_padding = require("appearance").padding_table

  wezterm.on("window-resized", function(window)
    util.compute_padding(window, cfg_padding)
  end);

  wezterm.on("window-config-reloaded", function(window)
    util.compute_padding(window, cfg_padding)
    -- wezterm.log_info(window:get_dimensions())
    -- wezterm.log_info(pane:get_dimensions())
  end);

end

return M
