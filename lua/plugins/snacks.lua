return {
	"folke/snacks.nvim",
	lazy = false,
	keys = {
		{
			"<leader>nd",
			function()
				require("snacks").toggle.dim():toggle()
			end,
		},
		{
			"<leader>nz",
			function()
				require("snacks").toggle.zen():toggle()
			end,
		},
	},
	opts = {
		dashboard = {
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
		toggle = {},
		dim = {},
		zen = {},
		bigfile = {},
		quickfile = {},
		input = {},
	},
}
