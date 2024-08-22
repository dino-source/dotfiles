local options = {
    ensure_installed = {
        "bash",
        "clojure",
        "cmake",
        "cpp",
        "gitignore",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "printf",
        "python",
        "rust",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
return options
