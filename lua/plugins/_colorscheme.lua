return {
	{
		"lmantw/themify.nvim",
		lazy = false,
		config = function()
			require("themify").setup({
				async = true,
				{
					"catppuccin/nvim",
					blacklist = {
						"catppuccin-latte",
					},
				},
				"slugbyte/lackluster.nvim",
			})
		end,
	},
}
