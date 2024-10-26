return {
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = { "catppuccin", "poimandres", "lackluster" },
				livePreview = true,
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
			})
			vim.cmd("colorscheme catppuccin")
		end,
	},
	{
		"olivercederborg/poimandres.nvim",
		name = "poimandres",
		lazy = false,
		priority = 1000,
		config = function()
			require("poimandres").setup({})
			vim.cmd("colorscheme poimandres")
		end,
	},
	{
		"slugbyte/lackluster.nvim",
		name = "lackluster",
		lazy = false,
		priority = 1000,
		init = function()
			-- vim.cmd.colorscheme("lackluster")
			-- vim.cmd.colorscheme("lackluster-hack") -- my favorite
			vim.cmd.colorscheme("lackluster-mint")
		end,
	},
}
