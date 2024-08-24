return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			navic = {
				enabled = true,
			},
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
