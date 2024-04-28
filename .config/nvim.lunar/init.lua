local base_dir = vim.env.LUNARVIM_BASE_DIR
    or (function()
        local init_path = debug.getinfo(1, "S").source
        return init_path:sub(2):match("(.*[/\\])"):sub(1, -2)
    end)()

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
    vim.opt.rtp:append(base_dir)
end

require("lvim.bootstrap"):init(base_dir)

require("lvim.config"):load()

local plugins = require "lvim.plugins"

require("lvim.plugin-loader").load { plugins, lvim.plugins }

require("lvim.core.theme").setup()

local Log = require "lvim.core.log"
Log:debug "Starting LunarVim"

local commands = require "lvim.core.commands"
commands.load(commands.defaults)

local options = { noremap = true }
vim.keymap.set("v", "jk", "<Esc>", options)
vim.keymap.set("x", "jk", "<Esc>", options)
vim.keymap.set("o", "jk", "<Esc>", options)
vim.keymap.set("t", "jk", "<Esc>", options)
vim.keymap.set("i", "jk", "<Esc>", options)
vim.keymap.set("c", "jk", "<Esc>", options)
