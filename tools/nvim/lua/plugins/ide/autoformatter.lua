return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      'gQ',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      python = { 'isort', 'black' },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { 'rustfmt', lsp_format = 'fallback' },
      -- Conform will run the first available formatter
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
    format_on_save = function(bufnr)
      -- Set of filetypes to auto-format on save (using table for O(1) lookup)
      local auto_format_filetypes = {
        javascript = true,
        typescript = true,
        javascriptreact = true,
        typescriptreact = true,
        -- lua = true,
        -- python = true,
        -- rust = true,
      }
      if auto_format_filetypes[vim.bo[bufnr].filetype] then
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
      return nil
    end,
  },
}
