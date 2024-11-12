return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<leader>cx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
		opts = {},
	},
	{
		"oskarrrrrrr/symbols.nvim",
		lazy = true,
		keys = {
			{
				"<leader>cs",
				"<cmd>Symbols<CR>",
				desc = "Symbols",
			},
		},
		config = function()
			local r = require("symbols.recipes")
			require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {})
		end,
	},
}
