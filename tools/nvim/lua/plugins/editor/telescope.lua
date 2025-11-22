return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-tree/nvim-web-devicons' }, -- Set opts if font errors occur
    'nvim-telescope/telescope-ui-select.nvim',
    "debugloop/telescope-undo.nvim",
  },
  event = 'VeryLazy',
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
          i = {
            ["<C-u>"] = "results_scrolling_up",
            ["<C-d>"] = "results_scrolling_down",
          }
        }
      },
      -- pickers = {
      --   -- Default configuration for builtin pickers goes here:
      --   -- picker_name = {
      --   --   picker_config_key = value,
      --   --   ...
      --   -- }
      --   -- Now the picker_config_key will be applied every time you call this
      --   -- builtin picker
      -- },
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ui-select')
    require("telescope").load_extension("undo")

    -- See `:help telescope.builtin`
    local map = vim.keymap.set
    local builtin = require 'telescope.builtin'
    map('n', '<leader>ff', builtin.find_files,                        { desc = 'Search files'          })
    map('n', '<leader>fg', builtin.live_grep,                         { desc = 'Search in files'       })
    map('n', '<leader>fb', builtin.buffers,                           { desc = 'Search buffers'        })
    map('n', '<leader>f.', builtin.oldfiles,                          { desc = 'Search recent files'   })
    map('n', '<f1>',       builtin.help_tags,                         { desc = 'Search help'           })
    map('n', '<leader>f/', builtin.current_buffer_fuzzy_find,         { desc = 'Search current buffer' })
    map('n', '<leader>fp', builtin.builtin,                           { desc = 'Select picker'         })

    -- Edit vimrc
    map('n', '<leader>fV', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Search config files' })

    -- Undo tree
    map('n', '<leader>fu', '<Cmd>Telescope undo<CR>',                 { desc = 'Telescope undo tree'   })

  end,
}
