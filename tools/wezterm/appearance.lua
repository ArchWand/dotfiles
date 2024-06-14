local M = {}

function M.apply_to_config(config)
  -- Colors
  config.colors = { -- Builtin Tango Dark
    ansi = {
      "#000000",
      "#cc0000",
      "#4e9a06",
      "#c4a000",
      "#3465a4",
      "#75507b",
      "#06989a",
      "#d3d7cf",
    },
    background = "#000000",
    brights = {
      "#555753",
      "#ef2929",
      "#8ae234",
      "#fce94f",
      "#729fcf",
      "#ad7fa8",
      "#34e2e2",
      "#eeeeec",
    },
    foreground = "#ffffff",
    selection_bg = "#b5d5ff",
    selection_fg = "#000000",

  }

  -- Cursor
  config.cursor_blink_ease_in = "Constant"
  config.cursor_blink_rate = 1000

  config.colors.cursor_bg = "#ffffff"
  config.colors.cursor_border = "#ffffff"
  config.colors.cursor_fg = "#000000"
  config.colors.compose_cursor = "orange"

  -- Visual bell
  config.visual_bell = {
    fade_in_function = "Constant",
    fade_in_duration_ms = 100,
    fade_out_function = "Constant",
    fade_out_duration_ms = 100,
    -- target = "CursorColor",
  }
  config.colors.visual_bell = '#1e1e2e'

  -- Tab bar
  config.use_fancy_tab_bar = false
  -- config.enable_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = true
  -- config.tab_bar_at_bottom = false
  config.tab_max_width = 32

  config.colors.tab_bar = {
    background = "rgba(0, 0, 0, 0.6)",

    active_tab = {
      bg_color = "#181825",
      fg_color = "White",
    },

    inactive_tab = {
      bg_color = "#000000",
      fg_color = "#7e7e7e",
    },

    -- inactive_tab_hover = {},
    -- new_tab = {},
    -- new_tab_hover = {},
  }

  -- Window padding
  config.window_padding = { top = 0, bottom = 0, left = 0, right = 0, }

  -- Configure per-window-size paddings
  M.padding_table = { w = {}, h = {} }
  -- Fullscreen
  M.padding_table.w[1920] = { left = 0, right = 0 }
  M.padding_table.h[1080] = { top = 4, bottom = 5 }

  -- Full
  M.padding_table.w[1914] = { left = 2, right = 2 }
  M.padding_table.h[1074] = { top = 1, bottom = 2 }

  -- Half
  M.padding_table.w[954] = { left = 2, right = 2 }
  M.padding_table.h[534] = { top = 4, bottom = 5 }

  util.set_default(M.padding_table.w, { left = 0, right = 0 })
  util.set_default(M.padding_table.h, { top = 0, bottom = 0 })


  config.inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 0.9,
  }

  config.window_background_opacity = 0.9
  -- config.text_background_opacity = 1.0
  config.macos_window_background_blur = 10
  config.win32_system_backdrop = "Acrylic"

  -- Command palette
  config.command_palette_bg_color = "rgba(20, 20, 20, 0.8)"
  config.command_palette_fg_color = "#ffffff"

end

return M
