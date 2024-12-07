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
	{
		"shortcuts/no-neck-pain.nvim",
		version = "*",
		opts = {
			width = 135,
			mappings = {
				enabled = true,
			},
		},
	},
}
