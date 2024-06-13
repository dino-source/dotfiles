-- Setup space key to be a leader key 
require("leader-key")

-- Load vim-options from lua/vim-options.lua:
require("vim-options")

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

-- Load keymappings from lua/keymappings.lua:
require("keymappings")

-- Start using lazy.nvim package manager + load neovim plugins from lua/plugins.lua:
require("lazy").setup("plugins")
