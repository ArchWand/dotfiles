local M = {}

local function calc_gap(window, pane)
  return window:get_dimensions().pixel_height - pane:get_dimensions().pixel_height
end

-- Choose a font size that minimizes padding, then pad the pane to the center
function M.minimize_padding(window, pane, cfg_font_size, cfg_padding, match_font_size, tol)
  tol = tol or {
    gap = 11,
    min_font_size = cfg_font_size,
    max_font_size = cfg_font_size + 1.0,
    step = 1.0,
  }

  -- Reset padding
  local overrides = window:get_config_overrides() or {}
  overrides.window_padding = cfg_padding
  window:set_config_overrides(overrides)

  -- If gap is too large, try to change the font size
  if match_font_size and calc_gap(window, pane) > tol.gap then
    local min_gap = math.huge
    local min_ind = cfg_font_size

    for size=tol.min_font_size,tol.max_font_size,tol.step do
      -- Try the different font sizes
      overrides.font_size = size
      window:set_config_overrides(overrides)
      local gap_size = calc_gap(window, pane)

      -- Keep track of which one was the best
      -- <= is less visually jarring than <
      if gap_size <= min_gap then
        min_gap = gap_size
        min_ind = size
        -- Minimize bouncing by returning early
        if gap_size <= tol.gap then break end
      end
    end

    overrides.font_size = min_ind
    window:set_config_overrides(overrides)
    wezterm.log_info(min_gap, min_ind)
  end

  -- Center
  local gap_size = calc_gap(window, pane)
  overrides.window_padding = {
    left = cfg_padding.left,
    right = cfg_padding.right,
    top = gap_size * 2/3,
    bottom = gap_size * 1/3,
  }
  window:set_config_overrides(overrides)
end

return M
