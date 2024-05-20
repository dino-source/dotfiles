-- Set more handy keymappings:
local options = { noremap = true }

INSERT_MODE = 'i'
NORMAL_MODE = 'n'

vim.keymap.set(INSERT_MODE, 'jk', '<Esc>', options) -- use 'jk' as <Esc> key

local open_terminal = ':ter<CR><S-a>'
local alt_t = '<A-t>'
vim.keymap.set(NORMAL_MODE, alt_t, open_terminal, options)

local quit_current_buffer = ':q!<CR>'
local alt_w = '<A-w>'
vim.keymap.set(NORMAL_MODE, alt_w, quit_current_buffer, options)

local save_and_quit = ':wqa<CR>' -- write changes, quit all buffers
local alt_q = '<A-q>'
vim.keymap.set(NORMAL_MODE, alt_q, save_and_quit, options)            

local open_neotree = ':Neotree filesystem reveal left<CR>'
local alt_e = '<A-e>'
vim.keymap.set(NORMAL_MODE, alt_e, open_neotree, options)

local go_to_next_buffer = ':bn<CR>'
local alt_n = '<A-n>'
vim.keymap.set(NORMAL_MODE, alt_n, go_to_next_buffer, options)

local go_to_prev_buffer = ':bp<CR>'
local alt_p = '<A-p>'
vim.keymap.set(NORMAL_MODE, alt_p, go_to_prev_buffer, options)

