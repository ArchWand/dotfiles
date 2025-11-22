local function map(m, lhs, rhs, o, d)
  local opts = (type(o) == 'table') and o or {}; opts.desc = d or o             -- Overload
  local mode = (#m == 0) and {''} or {}; for i=1,#m do mode[i] = m:sub(i,i) end -- Split mode string
  vim.keymap.set(mode, lhs, rhs, opts)                                          -- Make keymapping
end

vim.g.mapleader=' '
vim.g.maplocalleader='\\'

-- [[ Navigation ]] =========================================================== Related to moving the cursor inside Neovim
-- "Smart" beginning and end of line ------------------------------------------
map('nxi', '<Home>', GoBoL,                                                    'Beginning of line')
map('nx',  '<End>',  GoEoL,                                                    'End of line')
map('i',   '<End>',  '<C-o><End>', { remap = true },                           'End of line') -- Works with ve=onemore
map('nxo', 'H',      GoBoL,                                                    'Beginning of line')
map('nxo', 'L',      GoEoL,                                                    'End of line')

-- Use wrapped movement by default --------------------------------------------
map('nv', 'j',      'v:count ? "j" : "gj"', { expr = true },                   'Down')
map('nv', 'k',      'v:count ? "k" : "gk"', { expr = true },                   'Up')
map('nv', '<Down>', 'v:count ? "j" : "gj"', { expr = true },                   'Down')
map('nv', '<Up>',   'v:count ? "k" : "gk"', { expr = true },                   'Up')
map('nv', 'gj', 'v:count ? "gj" : "j"', { expr = true },                       'Wrapped down')
map('nv', 'gk', 'v:count ? "gk" : "k"', { expr = true },                       'Wrapped up')
-- <Cmd> doesn't account for cursorwant in insert mode, check if fixed.
-- Last checked: 11 May 2024
map('i', '<Down>', '<C-o>gj',                                                  'Down')
map('i', '<Up>',   '<C-o>gk',                                                  'Up')

-- Manage windows -------------------------------------------------------------
-- Partially managed by smart-splits
-- map('ni', '<C-A-h>', '<C-w><C-h>',                                             'Switch window LEFT')
-- map('ni', '<C-A-j>', '<C-w><C-j>',                                             'Switch window DOWN')
-- map('ni', '<C-A-k>', '<C-w><C-k>',                                             'Switch window UP')
-- map('ni', '<C-A-l>', '<C-w><C-l>',                                             'Switch window RIGHT')
map('n', '<A-i>', '<C-w>p',                                                    'Switch to most recent window')
map('i', '<A-i>', '<Cmd>wincmd p<CR>',                                         'Switch to most recent window')
-- map('ni', '<C-A-S-h>', '<C-w><',                                               'Increase split width')
-- map('ni', '<C-A-S-j>', '<C-w>+',                                               'Increase split height')
-- map('ni', '<C-A-S-k>', '<C-w>-',                                               'Decrease split height')
-- map('ni', '<C-A-S-l>', '<C-w>>',                                               'Decrease split width')

-- [[ Editing ]] ==============================================================
-- Single insertion/append/substitution/newline -------------------------------
map('n', '<leader>i', function() SingleInsert('i') end,                        'Insert single char')
map('n', '<leader>a', function() SingleInsert('a') end,                        'Insert single char at start')
map('n', '<leader>I', function() SingleInsert('I') end,                        'Append single char')
map('n', '<leader>A', function() SingleInsert('A') end,                        'Append single char at end')

-- Drag selection -------------------------------------------------------------
-- Managed by mini.move
-- -- Vertical (normal mode managed by plugin)
map('i', '<A-j>', function() vim.cmd.move('+'..vim.v.count1)   end,            'Drag line down')
map('i', '<A-k>', function() vim.cmd.move('-'..vim.v.count1+1) end,            'Drag line up')
-- map('v', '<A-j>',  [[":m '>+".(v:count1)."<CR>gv"]], { expr = true },          'Drag block Down')
-- map('v', '<A-k>',  [[":m '<-".(v:count1+1)."<CR>gv"]], { expr = true },        'Drag block up')
map('nvi', '<A-Down>', '<A-j>', { remap = true },                              'Move selection down')
map('nvi', '<A-Up>',   '<A-k>', { remap = true },                              'Move selection up')
-- -- Block horizontal
-- map('n', '<A-h>', '<<',                                                        'Un-indent')
-- map('n', '<A-l>', '>>',                                                        'Indent')
-- map('v', '<A-h>', '<gv',                                                       'Un-indent')
-- map('v', '<A-l>', '>gv',                                                       'Indent')
-- map('i', '<A-h>', '<C-d>',                                                     'Un-indent')
-- map('i', '<A-l>', '<C-t>',                                                     'Indent')
map('nvi', '<A-Left>',  '<A-h>', { remap = true },                             'Un-indent')
map('nvi', '<A-Right>', '<A-l>', { remap = true },                             'Indent')
-- Horizontal
map('n', '<A-S-h>', 'Xph',                                                     'Drag character left')
map('n', '<A-S-l>', 'xp',                                                      'Drag character right')
map('v', '<A-S-h>', 'xhPgvhoho',                                               'Drag block right')
map('v', '<A-S-l>', 'xpgvlolo',                                                'Drag block right')
map('i', '<A-S-h>', '<Esc><A-S-h>a', { remap = true },                         'Drag character left')
map('i', '<A-S-l>', '<Esc><A-S-l>a', { remap = true },                         'Drag character right')
map('nv', '<A-S-Left>',  '<A-S-h>', { remap = true },                         'Move selection left')
map('nv', '<A-S-Right>', '<A-S-l>', { remap = true },                         'Move selection right')

-- Miscellaneous --------------------------------------------------------------
-- Comment
map('i', '<C-/>', '<C-o>gcc', { remap = true },                                'Comment line' )
-- Replace word
map('n', 'crn', '*Ncgn',                                                       'Replace word' )

-- [[ Editor ]] ===============================================================
-- Common shortcuts -----------------------------------------------------------
-- Save
map('n',  '<C-s>',   '<Cmd>update<CR>',                                        'Save to file')
map('i',  '<C-s>',   '<Esc>:update<CR>',                                       'Save to file then exit insert mode')
map('ni', '<C-A-s>', '<Cmd>wa<CR>',                                            'Save all buffers')
-- Select all (not set in normal or visual mode because <C-a> is useful)
map('o', '<C-a>', '<Cmd>normal! m9ggVG<CR><Cmd>normal! `9<CR>',                'Select entire buffer')
map('v', 'gG', 'ggoG',                                                         'Select entire buffer')
-- Shift to select
map('i', '<S-Down>',  '<C-o>gh<Down>', { remap = true },                       'Down')
map('i', '<S-Up>',    '<C-o>gh<Up>', { remap = true },                         'Up')
map('i', '<S-Left>',  '<Left><C-o>gh',                                         'Left')
map('i', '<S-Right>', '<C-o>gh',                                               'Right')
map('s', '<S-Down>',  '<Down>', { remap = true },                              'Down')
map('s', '<S-Up>',    '<Up>', { remap = true },                                'Up')
map('s', '<S-Left>',  '<Left>',                                                'Left')
map('s', '<S-Right>', '<Right>',                                               'Right')

-- Convenience ----------------------------------------------------------------
map('n', 'ZA', '<Cmd>wqa<CR>',                                                 'Write and close all')
map('n', 'Za', '<Cmd>qa!<CR>',                                                 'Close all')
map('t', '<Esc>', '<C-\\><C-n>',                                               'Exit terminal mode') -- This won't work in all terminal emulators/tmux/etc.
-- Mistake leniency
map('no', 'gG', 'G',                                                           'Last line')
map('n', 'zZQ', 'ZQ',                                                          'Close buffer')
map('n', 'zZZ', 'ZZ',                                                          'Write and close buffer')

-- Toggle settings ------------------------------------------------------------
map('n', '<leader>tn', '<Cmd>setlocal relativenumber!<CR>',                    'Toggle relative numbering')
map('n', '<leader>ts', '<Cmd>set spell!<CR>',                                  'Toggle spellcheck')
map('n', '<leader>tw', '<Cmd>set wrap!<CR>',                                   'Toggle word wrapping')
map('n', '<leader>t<Tab>', '<Cmd>set list!<CR>',                               'Toggle whitespace rendering')
map('n', '<leader>t8', ToggleColorcolumn,                                      'Toggle colorcolumn')
map('n', '<leader>tr', ToggleAutoComment,                                      'Toggle autocomment')

-- [[ Fixes ]] ================================================================
-- Copy/paste with system clipboard
local function SmartReg(key)
  return (vim.v.register == '"' and '"+' or '') .. key
end
map('nx', 'y', function() return SmartReg('y') end, { expr = true },           'Yank')
map('n',  'Y', function() return SmartReg('y$') end, { expr = true },          'Yank to end')
map('nx', 'p', function() return SmartReg('p') end, { expr = true },           'Put')
map('nx', 'P', function() return SmartReg('P') end, { expr = true },           'Put before')
-- Easy access vim registers from the clipboard
map('n', '<leader>p', '<Cmd>let @+=@"<CR>',                                    'Send previous register to clipboard')

-- Maintain H and L functionality since H and L are mapped
map('n', 'MH', 'H',                                                            'Top of page')
map('n', 'MM', 'M',                                                            'Middle of page')
map('n', 'ML', 'L',                                                            'Bottom of page')

-- Maintain ability to view function signature
map('i', '<C-k>', vim.lsp.buf.signature_help,                                  'Function signature')
-- Assumes that digraphs should be handled by the IME

-- Miscellaneous --------------------------------------------------------------
-- Visual indent
map('v', '<', '<gv',                                                           'Un-indent')
map('v', '>', '>gv',                                                           'Indent')
-- Total search count
map('n', 'n', 'n<Cmd>lua print(SearchCount())<CR>')
map('n', 'N', 'N<Cmd>lua print(SearchCount())<CR>')
-- Make ' jump horizontally not just vertically
map('n', "'", '`')
