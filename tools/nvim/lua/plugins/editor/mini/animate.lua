return {
  -- Cursor path
  cursor = {
    -- Whether to enable this animation
    enable = true,

    -- Timing of animation (how steps will progress in time)
    -- timing = function() end,

    -- Path generator for visualized cursor movement
    -- path = function() end,
  },

  -- Vertical scroll
  scroll = {
    -- Whether to enable this animation
    enable = true,

    -- Timing of animation (how steps will progress in time)
    -- timing = function() end,

    -- Subscroll generator based on total scroll
    -- subscroll = function() end,
  },

  -- Window resize
  resize = {
    -- Whether to enable this animation
    enable = true,

    -- Timing of animation (how steps will progress in time)
    -- timing = function() end,

    -- Subresize generator for all steps of resize animations
    -- subresize = function() end,
  },

  -- Window open
  open = {
    -- Whether to enable this animation
    enable = true,

    -- Timing of animation (how steps will progress in time)
    -- timing = function() end,

    -- Floating window config generator visualizing specific window
    -- winconfig = function() end,

    -- 'winblend' (window transparency) generator for floating window
    -- winblend = function() end,
  },

  -- Window close
  close = {
    -- Whether to enable this animation
    enable = true,

    -- Timing of animation (how steps will progress in time)
    -- timing = function() end,

    -- Floating window config generator visualizing specific window
    -- winconfig = function() end,

    -- 'winblend' (window transparency) generator for floating window
    -- winblend = function() end,
  },
}
