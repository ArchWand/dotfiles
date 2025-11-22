return {
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'catppuccin/nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require('catppuccin').setup {
      -- flavour = 'auto', -- latte, frappe, macchiato, mocha
      -- background = { -- :h background
      --   light = 'latte',
      --   dark = 'mocha',
      -- },
      -- transparent_background = false, -- disables setting the background color.
      -- show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      -- term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      -- dim_inactive = {
      --   enabled = false, -- dims the background color of inactive window
      --   shade = 'dark',
      --   percentage = 0.15, -- percentage of the shade to apply to the inactive window
      -- },
      -- no_italic = false, -- Force no italic
      -- no_bold = false, -- Force no bold
      -- no_underline = false, -- Force no underline
      -- styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      --   comments = { 'italic' }, -- Change the style of comments
      --   conditionals = { 'italic' },
      --   loops = {},
      --   functions = {},
      --   keywords = {},
      --   strings = {},
      --   variables = {},
      --   numbers = {},
      --   booleans = {},
      --   properties = {},
      --   types = {},
      --   operators = {},
      --   -- miscs = {}, -- Uncomment to turn off hard-coded styles
      -- },
      -- color_overrides = {},
      -- custom_highlights = {},
      -- default_integrations = true,
      integrations = {
      --   cmp = true,
        fidget = true,
      --   gitsigns = true,
        -- indent_blankline = {
        --   enabled = true,
          -- scope_color = '',
          -- colored_indent_levels = false,
        -- }
        lsp_trouble = true,
        mason = true,
        -- mini = {
        --   enabled = true,
        --   indentscope_color = '',
        -- },
        -- native_lsp = {
        --   enabled = true,
        --   virtual_text = {
        --     errors = { "italic" },
        --     hints = { "italic" },
        --     warnings = { "italic" },
        --     information = { "italic" },
        --   },
        --   underlines = {
        --     errors = { "underline" },
        --     hints = { "underline" },
        --     warnings = { "underline" },
        --     information = { "underline" },
        --   },
        --   inlay_hints = {
        --     background = true,
        --   },
        -- },
        -- notify = false,
        -- nvimtree = true,
        -- treesitter_context = true
        -- treesitter = true,
        -- telescope = {
        --   enabled = true,
        --   -- style = "nvchad"
        -- }
        which_key = true,
        -- -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    }
  end,
}
