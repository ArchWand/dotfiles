local M = {}

function M.apply_to_config(config)
  -- Fonts
  config.font = wezterm.font_with_fallback({
    { family = "Source Code Pro", weight = "Medium" },
    "DejaVuSansM Nerd Font",
  })
  config.font_size = 12.0

  config.bold_brightens_ansi_colors = "BrightAndBold"
  -- config.line_height = 1.0

end

return M
