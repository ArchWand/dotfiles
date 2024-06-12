local M = {}

-- Center padding
local function recompute_padding(window, pane, cfg_padding)
  -- Reset padding
  local overrides = window:get_config_overrides() or {}
  overrides.window_padding = cfg_padding
  window:set_config_overrides(overrides)

  -- Center
  local vert_gap_size = window:get_dimensions().pixel_height - pane:get_dimensions().pixel_height
  local horz_gap_size = window:get_dimensions().pixel_width - pane:get_dimensions().pixel_width
  overrides.window_padding = {
    left = horz_gap_size * 1/2,
    right = horz_gap_size * 1/2,
    top = vert_gap_size * 1/2,
    bottom = vert_gap_size * 1/2,
  }
  window:set_config_overrides(overrides)
end

function M.apply_to_config(config)
  wezterm.on("window-resized", function(window, pane)
    recompute_padding(window, pane, config.window_padding)
  end);

  -- wezterm.on("window-config-reloaded", function(window, pane)
  --   recompute_padding(window, pane, config.window_padding)
  -- end);
end

return M
