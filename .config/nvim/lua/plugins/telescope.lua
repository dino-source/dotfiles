return {
    "nvim-telescope/telescope.nvim", tag = "0.1.6",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local builtin = require("telescope.builtin")
        -- Set up keymappings for some telescope features:
        vim.keymap.set('n', '<C-p>', builtin.find_files, {})
        vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
    end
}
