return {
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {
					"catppuccin-mocha",
					"catppuccin-frappe",
					"catppuccin-macchiato",
					-- "catppuccin-latte",
					"poimandres",
					"lackluster",
					"lackluster-hack",
					"lackluster-mint",
				},
				livePreview = true,
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin-colorscheme",
		lazy = true,
	},
	{
		"olivercederborg/poimandres.nvim",
		name = "poimandres-colorscheme",
		lazy = true,
	},
	{
		"slugbyte/lackluster.nvim",
		name = "lackluster-colorscheme",
		lazy = true,
	},
}
