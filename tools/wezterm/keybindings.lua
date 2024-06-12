local M = {}
local a = wezterm.action

function M.apply_to_config(config)
  -- config.send_composed_key_when_left_alt_is_pressed = false
  -- config.send_composed_key_when_right_alt_is_pressed = true
  -- config.use_ime = true
  -- config.use_dead_keys = false

  config.leader = { key = "z", mods = "CTRL" }
  config.keys = {
    -- Fix overridden keys
    { -- Enable backgrounding
      key = "z", mods = "LEADER|CTRL",
      action = a.SendKey { key = "z", mods = "CTRL", },
    },
    {
      key = "v", mods = "LEADER|CTRL",
      action = a.SendKey { key = "v", mods = "CTRL", },
    },
    -- Debug
    {
      key = "d", mods = "LEADER",
      action = a.ShowDebugOverlay,
    },
    -- Clear selection
    {
      key = "l", mods = "LEADER|CTRL",
      action = a.ClearSelection,
    },
    -- Cancel command
    {
      key = "Return", mods = "LEADER|CTRL",
      action = a.Multiple {
        a.SendKey { key = "Home" },
        a.SendKey { key = "#", mods = "SHIFT" },
        a.SendKey { key = "Return" },
      },
    },

    -- More powerful and convenient copy and paste
    {
      key = "c", mods = "CTRL",
      action = wezterm.action_callback(function(window, pane)
        local has_selection = window:get_selection_text_for_pane(pane) ~= ""
        if has_selection then
          window:perform_action(a.CopyTo "ClipboardAndPrimarySelection", pane)
          window:perform_action(a.ClearSelection, pane)
        else
          window:perform_action(a.SendKey { key = "c", mods = "CTRL" }, pane)
        end
      end),
    },
    { -- For MacOS parity
      key = "c", mods = "CMD",
      action = wezterm.action_callback(function(window, pane)
        local has_selection = window:get_selection_text_for_pane(pane) ~= ""
        if has_selection then
          window:perform_action(a.CopyTo "ClipboardAndPrimarySelection", pane)
          window:perform_action(a.ClearSelection, pane)
        else
          window:perform_action(a.SendKey { key = "c", mods = "CTRL" }, pane)
        end
      end),
    },
    -- { -- Conflicts with vim
    --   key = "v", mods = "CTRL",
    --   action = a.PasteFrom 'Clipboard',
    -- },
    {
      key = "S", mods = "CTRL|SHIFT",
      action = a.PasteFrom 'PrimarySelection',
    },

    -- More sensible split keybinds
    { -- Note that "Vertical" and "Horizontal" are swapped to match Neovim
      key = "L", mods = "CTRL|SHIFT",
      action = a.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
      key = "J", mods = "CTRL|SHIFT",
      action = a.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
      key = "H", mods = "CTRL|SHIFT",
      action = a.CloseCurrentPane { confirm = false },
    },
    {
      key = "K", mods = "CTRL|SHIFT",
      action = a.CloseCurrentPane { confirm = false },
    },

    -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f for MacOS
    {
      key = "LeftArrow", mods = "OPT",
      action = a.SendKey { key = "b", mods = "ALT" },
    },
    {
      key = "RightArrow", mods = "OPT",
      action = a.SendKey { key = "f", mods = "ALT" },
    },

  }

  -- Jump to panes/tabs/windows
  for i = 1, 9 do
    -- ALT + number to activate that pane
    table.insert(config.keys, {
      key = tostring(i), mods = "ALT",
      action = a.ActivatePaneByIndex(i - 1),
    })

    -- CTRL + SHIFT + number to activate that tab
    -- (default)

    -- CTRL + ALT + number to activate that window
    table.insert(config.keys, {
      key = tostring(i), mods = "CTRL|ALT",
      action = a.ActivateWindow(i - 1),
    })
  end

end

return M
