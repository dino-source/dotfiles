-- Use spaces instead of tabs and setup tab length:
vim.cmd("set expandtab")        -- tabs keypresses will be expanded into spaces
vim.cmd("set tabstop=4")        -- how many columns of whitespace is a \t char worth
vim.cmd("set softtabstop=4")    -- how many columns of whitespace is a tab keypress or a backspace keypress worth
vim.cmd("set shiftwidth=4")     -- how many columns of whitespace a “level of indentation” is worth

-- Load and install lazy.nvim package manager from GitHub:
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
}
local opts = {}

require("lazy").setup(plugins, opts)
