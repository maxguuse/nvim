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
				{
					"folke/tokyonight.nvim",
					blacklist = {
						"tokyonight-day",
					},
				},
				"olivercederborg/poimandres.nvim",
				"slugbyte/lackluster.nvim",
				"wtfox/jellybeans.nvim",
				"ilof2/posterpole.nvim",
				"vague2k/vague.nvim",
			})
		end,
	},
}
