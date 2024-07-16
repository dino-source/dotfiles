return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
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
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.clangd.setup({
                capabilities = capabilities,
                settings = {
                    clangd = {
                        InlayHints = {
                            Designators = true,
                            Enabled = true,
                            ParameterNames = true,
                            DeducedTypes = true,
                        },
                        fallbackFlags = { "-std=c++23" },
                    },
                },
            })
			lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
			lspconfig.pyright.setup({
                capabilities = capabilities
            })
			lspconfig.cmake.setup({
                capabilities = capabilities
            })
			lspconfig.bashls.setup({
                capabilities = capabilities
            })
			lspconfig.clojure_lsp.setup({
                capabilities = capabilities
            })

			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {})
			vim.keymap.set({ "n", "v" }, "<C-a>", vim.lsp.buf.code_action, {})
		end,
	},
}
