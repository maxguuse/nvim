return {
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
					lua = { "stylua" }, -- INSTALLED GLOBALLY
					go = {
						"gofmt", -- INSTALLED GLOBALLY
						"goimports", -- INSTALLED GLOBALLY
						"gci", -- INSTALLED GLOBALLY
						"golines", -- INSTALLED GLOBALLY
					},
					sql = { "sqlfmt" }, -- INSTALLED GLOBALLY
					yaml = { "yamlfmt" }, -- INSTALED GLOBALLY
					fish = { "fish" }, -- INSTALLED GLOBALLY
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
