return {
	{
		"petertriho/nvim-scrollbar",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("scrollbar").setup({})
		end,
	},
}
