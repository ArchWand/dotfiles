local M = {}

function M.set_default (t, d)
  local mt = {__index = function () return d end}
  setmetatable(t, mt)
end

-- Choose padding based on window size
function M.compute_padding(window, cfg_padding)
  -- Get window size and corresponding padding
  local w = cfg_padding.w[window:get_dimensions().pixel_width]
  local h = cfg_padding.h[window:get_dimensions().pixel_height]

  -- Set padding
  local overrides = window:get_config_overrides() or {}
  overrides.window_padding = {
    left = w.left,
    right = w.right,
    top = h.top,
    bottom = h.bottom,
  }
  window:set_config_overrides(overrides)
end

function M.is_mac()
  return wezterm.target_triple == "aarch64-apple-darwin"
end

return M
