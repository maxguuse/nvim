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
				"olivercederborg/poimandres.nvim",
				"slugbyte/lackluster.nvim",
				"Vallen217/eidolon.nvim",
				"wtfox/jellybeans.nvim",
			})
		end,
	},
}
