-- Use spaces instead of tabs and setup tab length:
vim.cmd("set expandtab")        -- tabs keypresses will be expanded into spaces
vim.cmd("set tabstop=4")        -- how many columns of whitespace is a \t char worth
vim.cmd("set softtabstop=4")    -- how many columns of whitespace is a tab keypress or a backspace keypress worth
vim.cmd("set shiftwidth=4")     -- how many columns of whitespace a “level of indentation” is worth
vim.g.mapleader = ' '

-- Download lazy.nvim package manager from GitHub and install it:
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- will be in ~/.local/share/nvim/lazy/lazy.nvim
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

-- Necessary local variables:
local plugins = {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup()
            -- setup must be called before loading
            vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.6",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
    }
}
local opts = {}

-- Start using lazy.nvim package manager:
require("lazy").setup(plugins, opts)

-- Define local variable 'config' for Treesitter plugin:
local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = {
        "lua", "python", "cpp", "bash", "make", "cmake", "json", "haskell",
        "java", "c_sharp", "clojure", "javascript", "html", "css"},
    highlight = {enable = true},
    indent = {enable = true},
})

-- Start using telescope plugin:
local builtin = require("telescope.builtin")
-- Set up keymappings for some telescope features:
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
