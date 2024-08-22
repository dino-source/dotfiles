require("global_constants")

local options = { noremap = true }

vim.keymap.set(mode.insert, "jk", "<Esc>", options) -- use 'jk' as <Esc> key

-- Bunch of local variables just to improve code readability
local alt_j = "<A-j>"
local alt_k = "<A-k>"
local alt_t = "<A-t>"
local alt_w = "<A-w>"
local alt_q = "<A-q>"
local alt_e = "<A-e>"
local alt_n = "<A-n>"
local alt_p = "<A-p>"
local alt_f = "<A-f>"

local open_terminal = ":ter<CR><S-a>"
vim.keymap.set(mode.normal, alt_t, open_terminal, options)

local quit_current_buffer = ":q!<CR>"
vim.keymap.set(mode.normal, alt_w, quit_current_buffer, options)

local save_and_quit = ":wqa<CR>" -- write changes, quit all buffers
vim.keymap.set(mode.normal, alt_q, save_and_quit, options)

local open_neotree = ":Neotree filesystem reveal left<CR>"
vim.keymap.set(mode.normal, alt_e, open_neotree, options)
vim.keymap.set(mode.normal, "<leader>e", open_neotree, options)

local go_to_next_buffer = ":bn<CR>"
vim.keymap.set(mode.normal, alt_n, go_to_next_buffer, options)

local go_to_prev_buffer = ":bp<CR>"
vim.keymap.set(mode.normal, alt_p, go_to_prev_buffer, options)

local move_current_line_up = "ddkP"
vim.keymap.set(mode.normal, alt_k, move_current_line_up, options)

local move_current_line_down = "ddp"
vim.keymap.set(mode.normal, alt_j, move_current_line_down, options)

-- Enable auto-formatting using none-ls plugin
vim.keymap.set(mode.normal, alt_f, vim.lsp.buf.format, options)
