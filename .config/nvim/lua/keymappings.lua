-- Set more handy keymappings:
local options = { noremap = true }
INSERT_MODE = 'i'
NORMAL_MODE = 'n'
vim.keymap.set(INSERT_MODE, 'jk', '<Esc>', options)                  -- Use 'jk' as <Escape> key
vim.keymap.set(NORMAL_MODE, '<leader>t', ':ter<CR><S-a>', options)   -- open terminal
vim.keymap.set(NORMAL_MODE, '<leader>w', ':q!<CR>', options)         -- quit current buffer
vim.keymap.set(NORMAL_MODE, '<leader>q', ':wqa<CR>', options)        -- write changes, quit all buffers
vim.keymap.set(NORMAL_MODE, '<leader>n', ':bn<CR>', options)         -- go to next buffer
vim.keymap.set(NORMAL_MODE, '<leader>p', ':bp<CR>', options)         -- go to prev buffer

-- Alternative keybindigs (in case leader key just stops working):
vim.keymap.set(NORMAL_MODE, '<A-w>', ':q!<CR>', options)             -- quit current buffer
vim.keymap.set(NORMAL_MODE, '<A-e>', ':Neotree filesystem reveal left<CR>', options) -- open neo-tree
vim.keymap.set(NORMAL_MODE, '<A-n>', ':bn<CR>', options)             -- go to next buffer
vim.keymap.set(NORMAL_MODE, '<A-p>', ':bp<CR>', options)             -- go to prev buffer

