return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			enabled = true,
			opts = { mode = "cursor", max_lines = 3 },
		},
	},
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSInstall", "TSUninstall", "TSInstallSync" },
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
