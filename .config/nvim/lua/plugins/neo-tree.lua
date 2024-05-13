return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        -- Set up keymappings for some neo-tree features:
        vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal left<CR>', {})
    end
}
