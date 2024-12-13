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
		scroll = {
			animate = {
				duration = { step = 10, total = 100 },
				easing = "linear",
			},
			spamming = 10, -- threshold for spamming detection
			-- what buffers to animate
			filter = function(buf)
				return vim.g.snacks_scroll ~= false
					and vim.b[buf].snacks_scroll ~= false
					and vim.bo[buf].buftype ~= "terminal"
			end,
		},
		toggle = {},
		dim = {},
		zen = {},
		bigfile = {},
		quickfile = {},
		input = {},
	},
}
