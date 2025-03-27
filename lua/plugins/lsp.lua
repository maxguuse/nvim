vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set({ "n", "x" }, "<F3>", '<cmd>lua require("conform").format()<cr>', opts)
		vim.keymap.set("n", "<C-CR>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	end,
})

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("lspconfig").util.default_config.capabilities,
				require("blink.cmp").get_lsp_capabilities()
			)
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"jsonls",
					"dockerls",
					"docker_compose_language_service",
					"lua_ls",
					"hyprls",
					"bashls",
					"cssls",
					"yamlls",
					"sqls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
					["cssls"] = function()
						require("lspconfig").cssls.setup({
							capabilities = capabilities,
							on_attach = function(client)
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentFormattingRangeProvider = false
							end,
							settings = {
								css = {
									validate = false, -- Disable validation if you want to ignore errors
								},
							},
						})
					end,
					["gopls"] = function()
						require("lspconfig").gopls.setup({
							capabilities = capabilities,
							on_attach = function(client)
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentFormattingRangeProvider = false
							end,
							settings = {
								gopls = {
									experimentalPostfixCompletions = true,
									analyses = {
										unusedparams = true,
										shadow = true,
									},
									staticcheck = true,
								},
							},
							init_options = {
								usePlaceholders = true,
							},
						})
					end,
					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							capabilities = capabilities,
							on_attach = function(client)
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentFormattingRangeProvider = false
							end,
						})
					end,
					["yamlls"] = function()
						require("lspconfig").yamlls.setup({
							capabilities = capabilities,
							on_attach = function(client)
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentFormattingRangeProvider = false
							end,
						})
					end,
					["sqls"] = function()
						require("lspconfig").sqls.setup({
							capabilities = capabilities,
							on_attach = function(client)
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentFormattingRangeProvider = false
							end,
						})
					end,
				},
			})
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "v1.*",
		lazy = true,
		event = { "BufReadPost", "BufNewFile", "CmdlineEnter" },
		opts = {
			keymap = {
				["<C-f>"] = { "show" },
				["<S-CR>"] = { "accept" },
				["<Tab>"] = { "select_next", "snippet_forward" },
				["<S-Tab>"] = { "select_prev", "snippet_backward" },
				["<C-k>"] = { "scroll_documentation_up" },
				["<C-j>"] = { "scroll_documentation_down" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			signature = { enabled = true },
			cmdline = {
				keymap = {
					["<S-CR>"] = { "show", "accept" },
				},
				completion = { menu = { auto_show = true } },
			},
		},
	},
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "gofmt", "goimports", "gci", "golines" },
					sql = { "sqlfmt" },
					yaml = { "yamlfmt" },
					fish = { "fish" },
				},
				formatters = {
					fish = {
						command = "fish_indent",
						args = { "-w", "$FILENAME" },
						stdin = false,
					},
				},
				format_on_save = false,
				format_after_save = {
					lsp_format = "fallback",
					async = true,
				},
			})

			require("conform").formatters.golines = {
				args = { "--no-chain-split-dots" },
			}

			require("conform").formatters.yamlfmt = {}
		end,
	},
}
