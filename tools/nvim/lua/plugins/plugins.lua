return {

  require 'plugins.display.colorscheme',
  require 'plugins.display.colorizer',
  require 'plugins.display.dressing',
  require 'plugins.display.lualine',
  require 'plugins.display.indent-blankline', -- Note: check if iter bug fixed
  require 'plugins.display.todo-comments',
  require 'plugins.display.which-key',

  require 'plugins.editor.bullets',
  require 'plugins.editor.bufresize',
  require 'plugins.editor.comment',
  require 'plugins.editor.harpoon',
  require 'plugins.editor.indent',
  require 'plugins.editor.mini',
  require 'plugins.editor.nvim-window',
  require 'plugins.editor.persistence',
  require 'plugins.editor.smart-splits',
  require 'plugins.editor.suda',
  require 'plugins.editor.surround',
  require 'plugins.editor.telescope',
  require 'plugins.editor.undotree',

  require 'plugins.external.gitsigns',
  require 'plugins.external.latex',
  require 'plugins.external.markdown',
  require 'plugins.external.oil',
  require 'plugins.external.plantuml',

  require 'plugins.ide.autoformatter',
  -- require 'plugins.ide.dap',
  require 'plugins.ide.linter',
  require 'plugins.ide.lsp',
  require 'plugins.ide.LuaSnip',
  require 'plugins.ide.nvim-cmp',
  require 'plugins.ide.treesitter',
  require 'plugins.ide.trouble',

}
