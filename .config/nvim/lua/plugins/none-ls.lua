return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.completion.spell,
                null_ls.builtins.diagnostics.cmake_lint,
                null_ls.builtins.formatting.cmake_format, -- Parse cmake listfiles and format them nicely
                null_ls.builtins.diagnostics.cppcheck, -- A tool for fast static analysis of C/C++ code
                null_ls.builtins.formatting.clang_format, -- A tool to format C/C++ code
                null_ls.builtins.formatting.black, -- The uncompromising Python code formatter
            },
        })
    end
}
