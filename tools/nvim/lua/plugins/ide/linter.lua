return { -- Linting
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      -- c = { 'clangtidy' },
      -- cpp = { 'clangtidy' },
      -- java = { 'checkstyle' },
      -- json = { 'jsonlint' },
      -- lua = { 'luacheck' },
      -- markdown = { 'vale', 'markdownlint' },
      -- python = { 'mypy', 'ruff' },
      -- text = { 'vale' },
    }

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
