source ~/.config/nvim/settings/utility.lua
source ~/.config/nvim/settings/options.vim
source ~/.config/nvim/settings/keymaps.lua
source ~/.config/nvim/settings/commands.vim

lua << EOF
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
vim.opt.rtp:prepend(lazypath)
require('lazy-bootstrap')
require('lazy').setup( { import = 'plugins' }, {
  change_detection = { notify = false },
})
EOF

" Further configuration in:
" ~/.config/nvim/after/ftplugin
" ~/.config/nvim/lua/plugins
