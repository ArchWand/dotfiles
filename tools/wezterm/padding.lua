local M = {}
M.padding_table = { w = {}, h = {} }

function M.apply_to_config(config)
  config.window_padding = { top = 0, bottom = 0, left = 0, right = 0, }

  -- Configure per-window-size paddings
  -- Laptop Fullscreen
  M.padding_table.w[1920] = { left = 0, right = 0 }
  M.padding_table.h[1080] = { top = 4, bottom = 5 }
  -- Laptop Full
  M.padding_table.w[1914] = { left = 2, right = 2 }
  M.padding_table.h[1074] = { top = 1, bottom = 2 }
  -- Laptop Half
  M.padding_table.w[954] = { left = 2, right = 2 }
  M.padding_table.h[534] = { top = 4, bottom = 5 }

  util.set_default(M.padding_table.w, { left = 0, right = 0 })
  util.set_default(M.padding_table.h, { top = 0, bottom = 0 })

  -- [[ Mac ]]
  if util.is_mac() then
    -- Laptop Fullscreen
    M.padding_table.h[1890] = { top = 9, bottom = 9 }
    -- Laptop Maximize
    M.padding_table.w[3024] = { left = 7, right = 8 }
    M.padding_table.h[1888] = { top = 8, bottom = 8 }
    -- Laptop Almost maximize
    M.padding_table.w[2722] = { left = 1, right = 1 }
    M.padding_table.h[1700] = { top = 4, bottom = 4 }
    -- Laptop Restore
    M.padding_table.w[0000] = { left = 0, right = 0 }
    M.padding_table.h[0000] = { top = 0, bottom = 0 }
    -- Laptop Half
    M.padding_table.w[1512] = { left = 8, right = 8 }

    util.set_default(M.padding_table.w, { left = 4, right = 0 })
    util.set_default(M.padding_table.h, { top = 4, bottom = 0 })
  end

end

return M
