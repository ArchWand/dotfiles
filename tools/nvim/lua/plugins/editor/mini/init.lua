return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      require('mini.ai').setup(       require 'plugins.editor.mini.ai')
      -- require('mini.animate').setup(  require 'plugins.utility.mini.animate')
      require('mini.bracketed').setup(require 'plugins.editor.mini.bracketed')
      require('mini.jump').setup(     require 'plugins.editor.mini.jump')
      require('mini.jump2d').setup(   require 'plugins.editor.mini.jump2d')
      require('mini.map').setup(      require 'plugins.editor.mini.map')
      require('mini.move').setup(     require 'plugins.editor.mini.move')
      -- require('mini.pairs').setup(    require 'plugins.editor.mini.pairs')
      -- require('mini.pick').setup(     require 'plugins.editor.mini.pick')
      -- require('mini.surround').setup( require 'plugins.editor.mini.surround')
    end,
  },
}
