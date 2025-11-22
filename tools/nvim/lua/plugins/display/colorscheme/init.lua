local a = require 'plugins.display.colorscheme.catppuccin'
local b = require 'plugins.display.colorscheme.tokyonight'

a.init = function()
  vim.cmd.colorscheme 'catppuccin-mocha'
end

return {
  a,
  b,
}
