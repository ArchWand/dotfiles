return {
  'bullets-vim/bullets.vim',
  config = function()

    -- You can choose which file types this plugin will work on:
    vim.g.bullets_enabled_file_types = {
      'markdown',
      'text',
      'gitcommit',
      'scratch'
    }

    -- You can disable this plugin for empty buffers (no filetype):
    -- vim.g.bullets_enable_in_empty_buffers = 1

    -- Add a leader key before default mappings:
    -- vim.g.bullets_mapping_leader = ''

    -- Customize key mappings
    vim.g.bullets_set_mappings = 0

    vim.g.bullets_custom_mappings = {
      {'imap',     '<CR>',   '<Plug>(bullets-newline)'},
      {'inoremap', '<C-CR>', '<CR>'},
      {'inoremap', '<S-CR>', '<CR>'},

      {'nmap', 'o', '<Plug>(bullets-newline)'},

      {'vmap', 'gN', '<Plug>(bullets-renumber)'},
      {'nmap', 'gN', '<Plug>(bullets-renumber)'},

      -- {'nmap', '<leader>x', '<Plug>(bullets-toggle-checkbox)'},

      {'nmap', '>>', '<Plug>(bullets-demote)'},
      {'vmap', '>', '<Plug>(bullets-demote)'},
      {'imap', '<C-t>', '<Plug>(bullets-demote)'},
      {'nmap', '<<', '<Plug>(bullets-promote)'},
      {'vmap', '<', '<Plug>(bullets-promote)'},
      {'imap', '<C-d>', '<Plug>(bullets-promote)'},
    }

    -- Enable/disable deleting the last empty bullet when hitting <cr> (insert mode) or o (normal mode):
    -- vim.g.bullets_delete_last_bullet_if_empty = 1

    -- Don't/add extra padding between the bullet and text when bullets are multiple characters long:
    vim.g.bullets_pad_right = 0

    -- Indent new bullets when the previous bullet ends with a colon:
    -- vim.g.bullets_auto_indent_after_colon = 1

    -- Maximum number of alphabetic characters to use for bullets:
    -- vim.g.bullets_max_alpha_characters = 2

    -- Nested outline bullet levels
    vim.g.bullets_outline_levels = {'ROM', 'ABC', 'num', 'abc', 'rom', 'std-', 'std*', 'std+'}
    -- Ordered list containing the heirarchical bullet levels, starting from the outer most level.
    -- Available bullet level options (cannot use the same marker more than once)
    -- ROM/rom = upper/lower case Roman numerals (e.g., I, II, III, IV)
    -- ABC/abc = upper/lower case alphabetic characters (e.g., A, B, C)
    -- std[-/*/+] = standard bullets using a hyphen (-), asterisk (*), or plus (+) as the marker.
    -- chk = checkbox (- [ ])

  end,
}
