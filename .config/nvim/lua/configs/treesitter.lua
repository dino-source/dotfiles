local options = {
    ensure_installed = {
        "bash",
        "clojure",
        "cmake",
        "cpp",
        "gitignore",
        "hyprlang",
        "json",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "printf",
        "python",
        "rust",
        "tcl",
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
