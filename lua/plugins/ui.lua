return {
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup({})
		end,
	},
}
