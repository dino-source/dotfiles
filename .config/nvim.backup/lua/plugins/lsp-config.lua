return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
                ensure_installed = {
                    "clangd",
                    "clang-format",
                }
            })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
                    "rust_analyzer",
					"lua_ls",
					"pyright",
                    "cmake",
                    "bashls",
                    "clojure_lsp",
				},
			})
		end,
	},
    {
        "simrat39/rust-tools.nvim",
        config = function()
            local rt = require("rust-tools")

            rt.setup({
              server = {
                on_attach = function(_, bufnr)
                  -- Hover actions
                  vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                  -- Code action groups
                  vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
              },
            })
        end,
    },
	{
		"neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
		config = function()
			local lspconfig = require("lspconfig")

			-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function()
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {buffer=0})
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
                vim.keymap.set("n", "gr", vim.lsp.buf.references, {buffer=0})
                vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {buffer=0})
                vim.keymap.set({ "n", "v" }, "<C-a>", vim.lsp.buf.code_action, {buffer=0})
            end

			lspconfig.clangd.setup({
                name = "clangd",
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--suggest-missing-includes",
                    "--log=verbose",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                    semanticHighlighting = true
                },
                filetypes = { "c", "cpp", "cc", "cxx", },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    clangd = {
                        InlayHints = {
                            Designators = true,
                            Enabled = true,
                            ParameterNames = true,
                            DeducedTypes = true,
                        },
                        fallbackFlags = { "-std=c++23", "-W", "-Wall", "-Wextra", "-Wpedantic", },
                    },
                },
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = {"rust"},
                settings = {
                    ["rust_analyzer"] = {
                        imports = {
                            granularity = {
                                group = "module",
                            },
                            prefix = "self",
                        },
                        cargo = {
                            allFeatures = true,
                        },
                        procMacro = {
                            enable = true,
                        }
                    },
                },
                cmd = {
                    "rustup", "run", "stable", "rust-analyzer",
                },
            })
			lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = {"lua"},
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
			lspconfig.pyright.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
			lspconfig.cmake.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
			lspconfig.bashls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
			lspconfig.clojure_lsp.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

		end,
	},
}
