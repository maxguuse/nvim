return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			enabled = true,
			opts = { mode = "cursor", max_lines = 3 },
		},
	},
	opts = {
		ensure_installed = {
			"go",
			"gomod",
			"gosum",
			"gowork",
			"lua",
			"json",
			"yaml",
			"toml",
			"dockerfile",
			"sql",
			"markdown",
			"markdown_inline",
			"vim",
			"vimdoc",
			"bash",
			"hyprlang",
			"regex",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<M-l>",
				node_incremental = "<M-l>",
				scope_incremental = false,
				node_decremental = "<M-h>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				kahead = true,
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				keymaps = {
					["aa"] = { query = "@parameter.outer", desc = "🌲select around function" },
					["ia"] = { query = "@parameter.inner", desc = "🌲select inside function" },
					["af"] = { query = "@function.outer", desc = "🌲select around function" },
					["if"] = { query = "@function.inner", desc = "🌲select inside function" },
					["ac"] = { query = "@class.outer", desc = "🌲select around class" },
					["ic"] = { query = "@class.inner", desc = "🌲select inside class" },
					["al"] = { query = "@loop.outer", desc = "🌲select around loop" },
					["il"] = { query = "@loop.inner", desc = "🌲select inside loop" },
					["ab"] = { query = "@block.outer", desc = "🌲select around block" },
					["ib"] = { query = "@block.inner", desc = "🌲select inside block" },
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			lsp_interop = {
				enable = true,
				border = "rounded",
				floating_preview_opts = {},
				peek_definition_code = {
					["<leader>df"] = "@function.outer",
					["<leader>dF"] = "@class.outer",
				},
			},
		},
	},
	config = function(_, opts)
		vim.filetype.add({
			extension = { rasi = "rasi" },
			pattern = {
				[".*/waybar/config"] = "jsonc",
				[".*/kitty/*.conf"] = "bash",
				[".*/hypr/.*%.conf"] = "hyprlang",
			},
		})

		require("nvim-treesitter.configs").setup(opts)
	end,
}
