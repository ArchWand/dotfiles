local rainbow_highlight = {
  indent = {
    highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }
  }
}

local whitespace_highlight = {
  indent = {
    highlight = {
      "CursorColumn",
      "Whitespace",
    },
    char = "" },
  whitespace = {
    highlight = {
      "CursorColumn",
      "Whitespace",
    },
    remove_blankline_trail = false,
  },
  scope = { enabled = true },
}

local presets = {
  default = function() require('ibl').setup() end,
  rainbow = function()
    local hooks = require 'ibl.hooks'
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2" })
    end)
    require('ibl').setup(rainbow_highlight)
  end,
  whitespace = function() require('ibl').setup(whitespace_highlight) end
}

-- Keys table
local keys = {}
for k in pairs(presets) do table.insert(keys, k) end
table.sort(keys)
-- Setup command to manage switching
vim.api.nvim_create_user_command('IBLSet',
  function(opts)
    local f = presets[opts.fargs[1]]
    if f then f() else
      local errstr = 'Valid options are:'
      for i = 1, #keys do errstr = errstr .. '    ' .. keys[i] end
      vim.notify(errstr)
    end
  end,
  { nargs = 1, complete =
    function(ArgLead)
      if #ArgLead == 0 then return keys end
      for k, _ in pairs(presets) do
        if k:sub(1, #ArgLead) == ArgLead then return { k } end
      end
      return keys
    end
  })


return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
  version = '3.5.4',
}
