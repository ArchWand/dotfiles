return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  event = 'VeryLazy',
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup({})

    local map = vim.keymap.set
    map('n', '<leader>h<CR>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Toggle harpoon' })
    map('n', '<leader>ha', function() harpoon:list():add() end,       { desc = 'Add to harpoon' })
    map('n', '<leader>hn', function() harpoon:list():prev() end,      { desc = 'Switch to next' })
    map('n', '<leader>hp', function() harpoon:list():next() end,      { desc = 'Switch to prev' })
    for i=1,9 do
      map('n', '<leader>h' .. i, function() harpoon:list():select(i) end,   { desc = 'Select file ' .. i })
    end

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers').new({}, {
        prompt_title = 'Harpoon',
        finder = require('telescope.finders').new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    map('n', '<leader>fh', function() toggle_telescope(harpoon:list()) end,
      { desc = 'Open harpoon picker' })
  end,
}
