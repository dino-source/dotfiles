return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = { -- Treesitter support for the following languages:
                "lua", "python", "cpp", "bash", "make", "cmake", "json", "haskell",
                "java", "c_sharp", "clojure", "javascript", "html", "css"
            },
            highlight = {enable = true},
            indent = {enable = true},
        })
    end
}

