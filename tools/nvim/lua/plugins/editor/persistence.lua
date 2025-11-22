return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  keys = {
    { -- restore the session for the current directory
      '<leader>qd',
      [[<Cmd>lua require('persistence').load()<Cr>]],
      desc = 'Restore session for current directory',
    },
    { -- restore the last session
      '<leader>ql',
     [[<Cmd>lua require('persistence').load({ last = true })<Cr>]],
      desc = 'Restore last session',
    },
    { -- stop Persistence => session won't be saved on exit
      '<leader>qs',
     [[<Cmd>lua require('persistence').stop()<Cr>]],
      desc = 'Stop Persistence',
    },
  },
  opts = {
    -- dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
    -- options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
    -- pre_save = nil, -- a function to call before saving the session
    -- save_empty = false, -- don't save if there are no open file buffers
  }
}
