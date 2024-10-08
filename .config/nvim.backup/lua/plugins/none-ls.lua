return {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.diagnostics.cmake_lint,
                null_ls.builtins.formatting.cmake_format,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.black, -- The uncompromising Python code formatter
                null_ls.builtins.formatting.isort, -- Library to sort imports alphabetically
            },
        })

    end
}
