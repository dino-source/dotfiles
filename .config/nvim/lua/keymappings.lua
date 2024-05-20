-- Set more handy keymappings:
local options = { noremap = true }
INSERT_MODE = 'i'
NORMAL_MODE = 'n'
vim.keymap.set(INSERT_MODE, 'jk', '<Esc>', options)                 -- Use 'jk' as <Escape> key
vim.keymap.set(NORMAL_MODE, '<leader>t', ':ter<CR><S-a>', options)  -- open terminal
vim.keymap.set(NORMAL_MODE, '<leader>w', ':n!<CR>', options)         -- quit current buffer
vim.keymap.set(NORMAL_MODE, '<leader>q', ':wqa<CR>', options)       -- write changes, quit all buffers
vim.keymap.set(NORMAL_MODE, '<leader>n', ':bn<CR>', options)         -- go to next buffer
vim.keymap.set(NORMAL_MODE, '<leader>n', ':bp<CR>', options)         -- go to prev buffer

