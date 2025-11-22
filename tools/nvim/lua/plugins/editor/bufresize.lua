return {
  'kwkarlwang/bufresize.nvim',
  opts = {
    resize = {
      keys = {
        { 'n', '<leader>rs', '', { desc = 'resize' } },
      },
      trigger_events = { "VimResized" },
      increment = 5,
    },
  },
}
