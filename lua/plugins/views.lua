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
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{
				"<leader>cs",
				"<cmd>Outline<CR>",
				desc = "Toggle outline",
			},
		},
		config = function()
			require("outline").setup({})
		end,
	},
}
