return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-project.nvim",
			"polirritmico/telescope-lazy-plugins.nvim",
			"crispgm/telescope-heading.nvim",
			"debugloop/telescope-undo.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					["lazy_plugins"] = {
						lazy_config = vim.fn.stdpath("config") .. "/init.lua",
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("project")
			telescope.load_extension("lazy_plugins")
			telescope.load_extension("heading")
		end,
	},
}
